import React from 'react'
import { useNavigate, useParams } from 'react-router-dom'

function PassportPhoto({ src, name }) {
  // Placeholder box with user silhouette if no image provided
  return (
    <div className="w-16 h-20 sm:w-20 sm:h-24 bg-white/5 border border-white/10 rounded-md overflow-hidden flex items-center justify-center">
      {src ? (
        // eslint-disable-next-line @next/next/no-img-element
        <img src={src} alt={name} className="w-full h-full object-cover" />
      ) : (
        <div className="text-3xl text-gray-400">👤</div>
      )}
    </div>
  )
}

export default function GroupModal({ groups }) {
  const { id } = useParams()
  const navigate = useNavigate()
  const close = () => navigate('/')

  const group = groups.find(g => g.id === id)
  if (!group) return null
  const list = group.type === 'group' ? group.members : [group]

  return (
    <div className="fixed inset-0 z-40">
      <div className="absolute inset-0 bg-black/70 backdrop-blur-sm" onClick={close} />
      <div className="relative z-50 max-w-4xl mx-auto mt-8 mb-8 bg-black/80 border border-white/10 rounded-xl shadow-card overflow-hidden">
        <div className="px-4 py-3 border-b border-white/10 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 rounded-lg bg-accent/20 border border-accent/40 grid place-items-center">
              <span className="text-accent" title="Group">👥</span>
            </div>
            <div>
              <div className="font-semibold">{group.name}</div>
              <div className="text-xs text-gray-400">{group.type === 'group' ? 'Group ID' : 'Public ID'}: {group.id} · {group.type === 'group' ? `${list.length} members` : 'Solo'}</div>
            </div>
          </div>
          <button className="btn" onClick={close}>Close</button>
        </div>
        <div className="p-4 max-h-[80vh] overflow-auto space-y-3">
          {list.map((m) => (
            <div key={m.id} className="card p-4">
              <div className="flex items-start gap-4">
                <PassportPhoto src={m.photo} name={m.name} />
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 w-full">
                  <Info label="Public ID" value={m.id} />
                  <Info label="Name" value={m.name} />
                  <Info label="Mobile" value={m.phone || '+91 9XXXX XXXXX'} />
                  <Info label="Emergency Contact" value={m.emergencyContact || '+91 8XXXX XXXXX'} />
                  <Info label="Email" value={m.email || 'user@example.com'} />
                  <Info label="Nationality" value={m.nationality || 'Indian'} />
                  <div className="sm:col-span-2">
                    <Info label="Address" value={m.address || '221B, Baker Street, Bengaluru, KA 560001'} />
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}

function Info({ label, value }) {
  return (
    <div>
      <div className="text-xs text-gray-400">{label}</div>
      <div className="font-medium break-words">{value}</div>
    </div>
  )
}
