import React, { useEffect } from 'react'
import { MapContainer, TileLayer, Tooltip, useMapEvents, useMap, Circle } from 'react-leaflet'
import 'leaflet/dist/leaflet.css'
import L from 'leaflet'
import 'leaflet.heat'

// Heat layer removed per requirement to show only zones

function ClickCatcher({ onMapClick }) {
  useMapEvents({
    click: (e) => {
      const { lat, lng } = e.latlng
      onMapClick?.([lat, lng])
    },
  })
  return null
}

function Recenter({ center }) {
  const map = useMap()
  useEffect(() => {
    if (center && Array.isArray(center)) {
      map.setView(center)
    }
  }, [center, map])
  return null
}

function RefreshControl({ onRefresh, position = 'topleft' }) {
  const map = useMap()
  useEffect(() => {
    const ctrl = L.control({ position })
    ctrl.onAdd = () => {
      const container = L.DomUtil.create('div', 'leaflet-bar')
      const link = L.DomUtil.create('a', '', container)
      link.href = '#'
      link.title = 'Refresh map'
      link.innerHTML = '⟳'
      link.style.width = '26px'
      link.style.height = '26px'
      link.style.lineHeight = '26px'
      link.style.textAlign = 'center'
      L.DomEvent.on(link, 'click', (e) => {
        L.DomEvent.stop(e)
        onRefresh?.()
        map.setView([20, 78], 4)
      })
      return container
    }
    ctrl.addTo(map)
    return () => ctrl.remove()
  }, [map, onRefresh, position])
  return null
}

function ZoomControlTopRight() {
  const map = useMap()
  useEffect(() => {
    const ctrl = L.control.zoom({ position: 'topright' })
    ctrl.addTo(map)
    return () => ctrl.remove()
  }, [map])
  return null
}

export default function MapView({ center, heatPoints, results, selected, onMapClick, allGroups = [], onRefresh, pulseAt }) {
  // Zones (lat, lng, radius meters)
  const safeZones = [
    { id: 'SZ-DEL', label: 'Safe Zone', center: [28.6139, 77.2090], radius: 8000 }, // Delhi
    { id: 'SZ-MUM', label: 'Safe Zone', center: [19.0760, 72.8777], radius: 8000 }, // Mumbai
    { id: 'SZ-BLR', label: 'Safe Zone', center: [12.9716, 77.5946], radius: 8000 }, // Bengaluru
  ]
  const dangerZones = [
    { id: 'DZ-DEL', label: 'Danger Zone', center: [28.61, 77.21], radius: 2000 },
    { id: 'DZ-MUM', label: 'Danger Zone', center: [19.08, 72.88], radius: 2500 },
  ]

  return (
    <MapContainer
      center={center}
      zoom={4}
      minZoom={2}
      style={{ height: '100%', width: '100%' }}
      whenCreated={(map) => { window.__leaflet_map_instance = map }}
      zoomControl={false}
    >
      <TileLayer
        // Dark tile style for contrast
        url="https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png"
        attribution="&copy; OpenStreetMap contributors & CartoDB"
      />

  {/* Map clicks disabled; only zone clicks populate results */}
      <Recenter center={center} />
  <ZoomControlTopRight />
  <RefreshControl onRefresh={onRefresh} position="topright" />

    {/* Zones: green safe areas and red danger areas (click to list groups) */}
    <ZonesLayer safeZones={safeZones} dangerZones={dangerZones} onZoneClick={onMapClick} />
    <LegendControl />
    <PulsingMarker pulseAt={pulseAt} />

      {/* No group/solo markers shown per requirement */}

      {/* Zones rendered above */}
    </MapContainer>
  )
}

function ZonesLayer({ safeZones = [], dangerZones = [], onZoneClick }) {
  return (
    <>
      {safeZones.map(z => (
        <Circle
          key={z.id}
          center={z.center}
          radius={z.radius}
          pathOptions={{ color: '#22c55e', weight: 2, fillColor: '#16a34a', fillOpacity: 0.25 }}
          eventHandlers={{ click: () => onZoneClick?.(z.center) }}
        >
          <Tooltip direction="top" opacity={1} permanent>
            <div className="text-xs">Safe Zone</div>
          </Tooltip>
        </Circle>
      ))}
      {dangerZones.map(z => (
        <Circle
          key={z.id}
          center={z.center}
          radius={z.radius}
          pathOptions={{ color: '#f87171', weight: 2, fillColor: '#ef4444', fillOpacity: 0.35 }}
          eventHandlers={{ click: () => onZoneClick?.(z.center) }}
        >
          <Tooltip direction="top" opacity={1} permanent>
            <div className="text-xs">Danger Zone</div>
          </Tooltip>
        </Circle>
      ))}
    </>
  )
}

function LegendControl({ position = 'bottomleft' }) {
  const map = useMap()
  useEffect(() => {
    const ctrl = L.control({ position })
    ctrl.onAdd = () => {
      const div = L.DomUtil.create('div', 'leaflet-control legend')
      div.style.background = 'rgba(17, 24, 39, 0.75)'
      div.style.border = '1px solid rgba(255,255,255,0.1)'
      div.style.borderRadius = '8px'
      div.style.padding = '8px 10px'
      div.style.color = '#e5e7eb'
      div.style.fontSize = '12px'
      div.style.lineHeight = '1.2'
      div.innerHTML = `
        <div style="display:flex;gap:10px;align-items:center;">
          <span style="display:inline-block;width:10px;height:10px;border-radius:50%;background:#22c55e"></span>
          Safe Zone
        </div>
        <div style="display:flex;gap:10px;align-items:center;margin-top:6px;">
          <span style="display:inline-block;width:10px;height:10px;border-radius:50%;background:#ef4444"></span>
          Danger Zone
        </div>
      `
      return div
    }
    ctrl.addTo(map)
    return () => ctrl.remove()
  }, [map, position])
  return null
}

function PulsingMarker({ pulseAt }) {
  const map = useMap()
  useEffect(() => {
    if (!pulseAt?.at) return
    const [lat, lng] = pulseAt.at

    // Ripple settings (~2.1s per ring)
    const rings = 3
    const startRadius = 80
    const maxRadius = 1800
    const step = 30
    const tick = 35 // ms
    const delayBetween = 180 // ms between ring starts
    const color = '#60a5fa'
    const fill = '#3b82f6'

    const timeouts = []
    const intervals = []
    const circles = []

    const makeRing = () => {
      const c = L.circle([lat, lng], {
        radius: startRadius,
        color,
        weight: 2,
        fillColor: fill,
        fillOpacity: 0.22,
      }).addTo(map)
      circles.push(c)
      let r = startRadius
      const i = setInterval(() => {
        r += step
        if (r >= maxRadius) {
          clearInterval(i)
          c.remove()
        } else {
          c.setRadius(r)
          const op = Math.max(0, 0.22 * (1 - r / maxRadius))
          c.setStyle({ fillOpacity: op, opacity: Math.max(0.18, op) })
        }
      }, tick)
      intervals.push(i)
    }

    for (let k = 0; k < rings; k++) {
      const t = setTimeout(makeRing, k * delayBetween)
      timeouts.push(t)
    }

    // Fly to location for better focus
    map.flyTo([lat, lng], Math.max(map.getZoom(), 12), { duration: 0.8 })

    return () => {
      timeouts.forEach(clearTimeout)
      intervals.forEach(clearInterval)
      circles.forEach(c => c.remove())
    }
  }, [pulseAt, map])
  return null
}
