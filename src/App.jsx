import React, { useMemo, useState } from 'react'
import { Toaster, toast } from 'react-hot-toast'
import MapView from './components/MapView'
import IntroSplash from './components/IntroSplash'
import SearchSidebar from './components/SearchSidebar'
import ResultsPanel from './components/ResultsPanel'
import GroupDetails from './components/GroupDetails'
import NotificationsPanel from './components/NotificationsPanel'
import GroupModal from './components/GroupModal'
import EFIRModal from './components/EFIRModal'
import stations from './data/stations'
import mock from './data/mockData'
import tourists from './data/tourists'
import { findNearbyGroups, findByGroupId, findByUserId } from './utils/search'
import { Routes, Route, useNavigate } from 'react-router-dom'

export default function App() {
  const navigate = useNavigate()
  const [groups] = useState(mock.groups)
  // Build heat points from tourists dataset for better density map
  const [heatPoints] = useState(() => {
    if (Array.isArray(tourists) && tourists.length) {
      // Map to [lat, lng, intensity]; slightly vary intensity by city clusters
      return tourists.map(t => [t.location[0], t.location[1], 0.6])
    }
    return mock.heatPoints
  })
  const [efirs, setEfirs] = useState(mock.efirs)
  const [results, setResults] = useState([])
  const [selected, setSelected] = useState(null)
  const [center, setCenter] = useState([20, 78]) // India-ish default
  const [notifications, setNotifications] = useState(mock.notifications)
  const [nearbyCount, setNearbyCount] = useState(0)
  const [pulseAt, setPulseAt] = useState(null) // latlng for map pulse
  const [showIntro, setShowIntro] = useState(true)
  const [introFade, setIntroFade] = useState(false)

  React.useEffect(() => {
    const t1 = setTimeout(() => setIntroFade(true), 2400) // start fade after ~2.4s
    const t2 = setTimeout(() => setShowIntro(false), 2900) // remove after ~2.9s
    return () => { clearTimeout(t1); clearTimeout(t2) }
  }, [])

  const onSearchGroupId = (groupId) => {
    const res = findByGroupId(groups, groupId)
    setSelected(null)
    setResults(res)
    setNearbyCount(res.length)
    if (res.length) setCenter(res[0].lastLocation)
  }

  const onSearchUserId = (userId) => {
    const res = findByUserId(groups, userId)
    setSelected(null)
    setResults(res)
    setNearbyCount(res.length)
    if (res.length) setCenter(res[0].lastLocation)
  }

  // Locate tourist by generated ID from tourists dataset; also pulse the map
  const onSearchTouristId = (tid) => {
    const idNorm = tid?.trim().toLowerCase()
    if (!idNorm) return
    const t = tourists.find(x => x.id.toLowerCase() === idNorm)
    if (t) {
      const loc = t.location
      setCenter(loc)
      setPulseAt({ at: loc, ts: Date.now() })
      // Show a lightweight toast-like notification via Results panel by clearing
      setSelected(null)
      setResults([])
      setNearbyCount(0)
      toast.success(`Located ${t.name ?? t.id}`)
    } else {
      toast.error('Tourist ID not found')
    }
  }

  const onMapClick = (latlng) => {
    // Zone click: show groups only (exclude solos)
    const resAll = findNearbyGroups(groups, latlng, 30) // km radius
    const res = resAll.filter(g => g.type === 'group')
    setSelected(null)
    setResults(res)
    setNearbyCount(res.length)
    if (res.length) setCenter(latlng)
  }

  const onSelectGroup = (grp) => {
    setSelected(grp)
    // update count relative to the selected group's last location
    const res = findNearbyGroups(groups, grp.lastLocation, 30)
    setNearbyCount(res.length)
    navigate(`/group/${grp.id}`)
  }

  const pushHelp = () => {
    // pick a random entry from groups as the requester
    const pool = groups.flatMap(g => g.type === 'group' ? g.members : [g])
    const who = pool[Math.floor(Math.random() * pool.length)]
    const loc = [
      who.lastLocation?.[0] ?? (15 + Math.random() * 20),
      who.lastLocation?.[1] ?? (70 + Math.random() * 20),
    ]
    const note = {
      id: 'N' + Math.random().toString(36).slice(2, 8),
      type: 'help',
      message: `${who.name} (${who.id}) requested help`,
      location: loc,
      ts: new Date().toISOString(),
    }
    setNotifications((prev) => [note, ...prev])
    toast.error('Help request received', { icon: '🚨' })
    setCenter(loc)
  }

  // Update FIR (description/status) by police
  const onUpdateEFIR = (firId, { policeNotes, status }) => {
    setEfirs(prev => prev.map(f => f.id === firId ? { ...f, policeNotes: (policeNotes ?? f.policeNotes), status: (status ?? f.status), updatedTs: new Date().toISOString() } : f))
    if (policeNotes) toast.success('Notes saved')
    if (status && status !== 'Submitted') toast.success(`Status updated to ${status}`)
  }

  // Transfer FIR to a station with optional notes
  const onTransferEFIR = (firId, stationId, notes) => {
    const station = stations.find(s => s.id === stationId)
    setEfirs(prev => prev.map(f => f.id === firId ? { ...f, transferredTo: stationId, transferNotes: notes, transferTs: new Date().toISOString() } : f))
    toast.success(`Transferred to ${station?.name ?? 'selected station'}`)
  }

  // Warn if center falls into a danger zone at deep zoom (handled via heat map zoom awareness)
  // Simple check against the same danger zones used in MapView
  const dangerZones = [
    { id: 'DZ-1', center: [28.61, 77.21], radiusKm: 1.2 },
    { id: 'DZ-2', center: [19.08, 72.88], radiusKm: 1.5 },
  ]
  React.useEffect(() => {
    // Approximated by checking last selected/results change; toast once per movement
    const isIn = dangerZones.some(z => {
      const d = Math.hypot((center[0] - z.center[0]) * 110.574, (center[1] - z.center[1]) * 111.320)
      return d <= z.radiusKm
    })
    if (isIn) {
      toast('Danger zone nearby', { icon: '⚠️' })
    }
  }, [center])

  const refreshMap = () => {
    setResults([])
    setSelected(null)
    setNearbyCount(0)
    setCenter([20, 78])
    setPulseAt(null)
  }

  // When user clicks Locate in notifications, center and pulse
  const onLocate = (latlng) => {
    setCenter(latlng)
    setPulseAt({ at: latlng, ts: Date.now() })
  }

  const header = useMemo(() => (
    <header className="w-full border-b border-white/10 bg-navbar/95 backdrop-blur sticky top-0 z-20">
      <div className="max-w-none px-4 py-3 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-9 h-9 rounded-lg bg-gradient-to-br from-accent/30 to-white/10 border border-accent/40 grid place-items-center shadow-card">
            <span className="text-accent text-lg" title="Shield">🛡️</span>
          </div>
          <div>
            <h1 className="text-base sm:text-lg font-semibold tracking-wide">Police Dashboard</h1>
          
          </div>
        </div>
        <div className="hidden sm:flex items-center gap-2">
          <button className="btn" onClick={() => navigate('/efir')}>E-FIR</button>
        </div>
      </div>
    </header>
  ), [navigate])

  return (
    <div className="min-h-full flex flex-col">
      {showIntro && <IntroSplash fadingOut={introFade} />}
      {header}
         <div className="flex-1 grid grid-cols-[minmax(0,1fr)_420px] gap-4 p-4 max-w-none mx-0 w-full">
        {/* Left: Big Map */}
        <div className="card p-0 h-[calc(100vh-6rem)] overflow-hidden">
          <MapView
            center={center}
            heatPoints={heatPoints}
            results={results}
            selected={selected}
            onMapClick={onMapClick}
            allGroups={groups}
            onRefresh={refreshMap}
            pulseAt={pulseAt}
          />
        </div>
        {/* Right: Panels */}
        <div className="flex flex-col gap-4 h-[calc(100vh-6rem)] overflow-auto">
          <div className="card p-4">
            <SearchSidebar onSearchGroupId={onSearchGroupId} onSearchUserId={onSearchUserId} onSearchTouristId={onSearchTouristId} nearbyCount={nearbyCount} />
          </div>
          <div className="card p-4">
            <NotificationsPanel notifications={notifications} onLocate={onLocate} />
          </div>
          <div className="card p-4">
            <ResultsPanel results={results} onSelect={onSelectGroup} />
          </div>
          {selected && (
            <div className="card p-4">
              <GroupDetails data={selected} onLocate={onLocate} />
            </div>
          )}
        </div>
      </div>
      {/* Route-driven modal overlay */}
      <Routes>
  <Route path="/group/:id" element={<GroupModal groups={groups} onLocate={onLocate} />} />
        <Route path="/efir" element={<EFIRModal efirs={efirs} onLocate={onLocate} onUpdateEFIR={onUpdateEFIR} onTransferEFIR={onTransferEFIR} stations={stations} />} />
      </Routes>
      <Toaster position="top-center" />
    </div>
  )
}
