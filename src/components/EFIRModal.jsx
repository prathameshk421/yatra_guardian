import React, { useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'

export default function EFIRModal({ efirs = [], onLocate, onUpdateEFIR, onTransferEFIR, stations = [] }) {
  const navigate = useNavigate()
  const close = () => navigate('/')
  const [transferFIR, setTransferFIR] = useState(null) // FIR object for transfer modal
  const [openId, setOpenId] = useState(null) // expanded FIR id
  const cityGrouped = useMemo(() => {
    const hq = stations.filter(s => s.type === 'HQ')
    const byCity = stations.filter(s => s.type !== 'HQ').reduce((acc, s) => {
      acc[s.city] = acc[s.city] || []
      acc[s.city].push(s)
      return acc
    }, {})
    return { hq, byCity }
  }, [stations])

  return (
    <div className="fixed inset-0 z-40">
      <div className="absolute inset-0 bg-black/70 backdrop-blur-sm" onClick={close} />
      <div className="relative z-50 inset-0 h-full w-full bg-black/85 border-t border-white/10 rounded-none shadow-card overflow-hidden flex flex-col">
        <div className="px-4 py-3 border-b border-white/10 flex items-center justify-between sticky top-0 z-10 bg-black/85">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 rounded-lg bg-accent/20 border border-accent/40 grid place-items-center">
              <span className="text-accent" title="E-FIR">📄</span>
            </div>
            <div>
              <div className="font-semibold">E-FIR Submissions</div>
              <div className="text-xs text-gray-400">{efirs.length} records</div>
            </div>
          </div>
          <button className="btn" onClick={close}>Close</button>
        </div>
        <div className="p-4 flex-1 overflow-auto space-y-3">
          {efirs?.length ? efirs.map(f => {
            const isOpen = openId === f.id
            return (
              <div key={f.id} className="card p-0 overflow-hidden">
                {/* Summary header (click to expand) */}
                <button className="w-full text-left px-4 py-3 flex items-start justify-between gap-4 hover:bg-white/5 transition" onClick={() => setOpenId(isOpen ? null : f.id)}>
                  <div>
                    <div className="font-medium">{f.title}</div>
                    <div className="text-xs text-gray-400">FIR ID: {f.id} • {new Date(f.ts).toLocaleString()}</div>
                    <div className="mt-1 text-sm">By: {f.name} ({f.userId})</div>
                  </div>
                  <div className="flex items-center gap-3">
                    <span className={`badge ${f.status === 'Submitted' ? 'bg-blue-500/20 text-blue-300' : f.status === 'In Review' ? 'bg-amber-500/20 text-amber-300' : 'bg-green-500/20 text-green-300'}`}>{f.status}</span>
                    <span className={`text-gray-300 transition-transform ${isOpen ? 'rotate-90' : ''}`}>›</span>
                  </div>
                </button>
                {/* Details (hidden until expanded) */}
                {isOpen && (
                  <div className="px-4 pb-4 pt-2">
                    <div className="text-sm text-gray-300">{f.description}</div>
                    <div className="mt-1 text-xs text-gray-400">Location: {f.location?.map(n => n.toFixed(3)).join(', ')}</div>
                    {f.transferredTo && (
                      <div className="mt-1 text-xs text-amber-300">Transferred to: {stations.find(s=>s.id===f.transferredTo)?.name} ({stations.find(s=>s.id===f.transferredTo)?.city || 'HQ'})</div>
                    )}
                    {f.policeNotes && (
                      <div className="mt-2 text-xs text-gray-300"><span className="text-gray-400">Police notes:</span> {f.policeNotes}</div>
                    )}
                    {/* Police Update Form */}
                    <div className="mt-3 grid sm:grid-cols-2 gap-3">
                      <PoliceNotesForm
                        fir={f}
                        onSave={(notes) => onUpdateEFIR?.(f.id, { policeNotes: notes })}
                      />
                      <PoliceStatusForm
                        fir={f}
                        onSave={(status) => onUpdateEFIR?.(f.id, { status })}
                      />
                    </div>
                    {/* Actions */}
                    <div className="mt-3 flex items-center justify-between">
                      <button className="btn" onClick={() => onLocate?.(f.location)}>Locate</button>
                      <button className="btn" onClick={() => setTransferFIR(f)}>Transfer</button>
                    </div>
                  </div>
                )}
              </div>
            )
          }) : (
            <div className="text-sm text-gray-400">No E-FIRs available.</div>
          )}
        </div>
      </div>
      {/* Transfer popup modal */}
      {transferFIR && (
        <TransferModal
          fir={transferFIR}
          groupedStations={cityGrouped}
          onCancel={() => setTransferFIR(null)}
          onConfirm={(stationId, notes) => { onTransferEFIR?.(transferFIR.id, stationId, notes); setTransferFIR(null) }}
        />)
      }
    </div>
  )
}

function PoliceNotesForm({ fir, onSave }) {
  const [notes, setNotes] = useState(fir.policeNotes || '')
  return (
    <div>
      <label className="block text-xs text-gray-300 mb-1">Police description/notes</label>
      <textarea className="input h-20" value={notes} onChange={(e) => setNotes(e.target.value)} placeholder="Add investigation notes, actions taken, etc." />
      <div className="mt-2 flex justify-end">
        <button className="btn" onClick={() => onSave?.(notes)} disabled={!notes.trim()}>Save Notes</button>
      </div>
    </div>
  )
}

function PoliceStatusForm({ fir, onSave }) {
  const [status, setStatus] = useState(fir.status || 'Submitted')
  return (
    <div>
      <label className="block text-xs text-gray-300 mb-1">Update status</label>
      <select className="input bg-white text-black" value={status} onChange={(e) => setStatus(e.target.value)}>
        <option>Submitted</option>
        <option>In Review</option>
        <option>Investigating</option>
        <option>Resolved</option>
      </select>
      <div className="mt-2 flex justify-end">
        <button className="btn" onClick={() => onSave?.(status)}>Update Status</button>
      </div>
    </div>
  )
}

function TransferModal({ fir, groupedStations, onCancel, onConfirm }) {
  const [selectedStation, setSelectedStation] = useState('')
  const [notes, setNotes] = useState('')
  const [showCitySearch, setShowCitySearch] = useState(false)
  const [query, setQuery] = useState('')

  // Nearby calculation (Haversine)
  const toRad = (x) => (x * Math.PI) / 180
  const haversine = (a, b) => {
    const [lat1, lon1] = a
    const [lat2, lon2] = b
    const R = 6371
    const dLat = toRad(lat2 - lat1)
    const dLon = toRad(lon2 - lon1)
    const A = Math.sin(dLat/2)**2 + Math.cos(toRad(lat1))*Math.cos(toRad(lat2))*Math.sin(dLon/2)**2
    return 2 * R * Math.atan2(Math.sqrt(A), Math.sqrt(1 - A))
  }

  const allStations = useMemo(() => {
    const hq = groupedStations.hq
    const others = Object.values(groupedStations.byCity).flat()
    return [...hq, ...others]
  }, [groupedStations])

  const nearby = useMemo(() => {
    const loc = fir.location
    return allStations
      .filter(s => Array.isArray(s.latLng))
      .map(s => ({ ...s, distance: haversine(loc, s.latLng) }))
      .sort((a,b) => a.distance - b.distance)
      .slice(0, 8) // top 8 nearby
  }, [allStations, fir.location])

  const cityNormalized = (s) => s.toLowerCase().replace(/\s+/g, '')
  const matchesCity = (city, q) => cityNormalized(city).includes(cityNormalized(q))
  const cityList = useMemo(() => Object.keys(groupedStations.byCity).sort(), [groupedStations])
  const filteredCities = useMemo(() => {
    if (!query.trim()) return cityList
    return cityList.filter(c => matchesCity(c, query))
  }, [cityList, query])

  return (
    <div className="fixed inset-0 z-[60] flex items-center justify-center p-4">
      <div className="absolute inset-0 bg-black/70" onClick={onCancel} />
      <div className="relative z-[61] w-full max-w-3xl max-h-[80vh] bg-black/85 border border-white/10 rounded-xl shadow-card overflow-hidden flex flex-col">
        <div className="px-4 py-3 border-b border-white/10 flex items-center justify-between">
          <div className="font-semibold">Transfer FIR {fir.id}</div>
          <div className="flex items-center gap-2">
            <button className="btn" onClick={() => setShowCitySearch(true)}>Another city</button>
            <button className="btn" onClick={onCancel}>Close</button>
          </div>
        </div>
        <div className="p-4 overflow-auto space-y-4">
          {/* Nearby first */}
          <div>
            <div className="text-xs text-gray-300 mb-2">Nearby police stations</div>
            <div className="flex flex-wrap gap-2">
              {nearby.map(s => (
                <button key={s.id} className={`btn ${selectedStation===s.id?'ring-2 ring-accent/60':''}`} onClick={() => setSelectedStation(s.id)}>
                  {s.name} <span className="text-xs text-gray-400 ml-1">({s.distance.toFixed(1)} km)</span>
                </button>
              ))}
            </div>
          </div>

          {/* City search panel (toggle) */}
          {showCitySearch && (
            <div className="card p-3">
              <div className="flex items-center justify-between gap-2">
                <div className="flex-1">
                  <label className="block text-xs text-gray-300 mb-1">Search city</label>
                  <input className="input bg-white text-black" placeholder="Type city e.g. Mum, Del, Jai" value={query} onChange={(e) => setQuery(e.target.value)} />
                </div>
                <button className="btn" onClick={() => { setShowCitySearch(false); setQuery('') }}>Close</button>
              </div>
              <div className="mt-3 grid sm:grid-cols-2 gap-2">
                {filteredCities.map(city => (
                  <div key={city} className="card p-2">
                    <div className="text-xs text-gray-400 mb-1">{city}</div>
                    <div className="flex flex-wrap gap-2">
                      {groupedStations.byCity[city].map(s => (
                        <button key={s.id} className={`btn ${selectedStation===s.id?'ring-2 ring-accent/60':''}`} onClick={() => setSelectedStation(s.id)}>
                          {s.name}
                        </button>
                      ))}
                    </div>
                  </div>
                ))}
                {!filteredCities.length && (
                  <div className="text-xs text-gray-400">No matching cities.</div>
                )}
              </div>
            </div>
          )}

          {/* Notes */}
          <div className="card p-3 bg-white/5 border-white/10">
            <div className="text-xs text-gray-300 mb-1">Transfer notes (optional)</div>
            <textarea className="input h-24" value={notes} onChange={(e) => setNotes(e.target.value)} placeholder="Add reason, context, case linkage, etc." />
          </div>
        </div>
        <div className="px-4 py-3 border-t border-white/10 flex justify-end gap-2">
          <button className="btn" onClick={onCancel}>Cancel</button>
          <button className="btn" disabled={!selectedStation} onClick={() => onConfirm?.(selectedStation, notes)}>Transfer</button>
        </div>
      </div>
    </div>
  )
}
