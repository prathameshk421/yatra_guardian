import React from 'react'

export default function GroupDetails({ data }) {
  if (!data) return null
  const isGroup = data.type === 'group'
  return (
    <div>
      <div className="flex items-center justify-between mb-3">
        <h2 className="text-lg font-semibold">Details</h2>
        <span className={`badge ${isGroup ? 'bg-blue-500/20 text-blue-300' : 'bg-green-500/20 text-green-300'}`}>{isGroup ? 'Group' : 'Solo'}</span>
      </div>
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <div className="card p-3">
          <div className="text-xs text-gray-400">Name</div>
          <div className="font-medium">{data.name}</div>
        </div>
        <div className="card p-3">
          <div className="text-xs text-gray-400">{isGroup ? 'Group ID' : 'Public ID'}</div>
          <div className="font-medium">{data.id}</div>
        </div>
        <div className="card p-3">
          <div className="text-xs text-gray-400">Last Location</div>
          <div className="font-medium">{data.lastLocation?.map(n => n.toFixed(3)).join(', ')}</div>
        </div>
        <div className="card p-3">
          <div className="text-xs text-gray-400">Status</div>
          <div className="font-medium">Active</div>
        </div>
      </div>
      {isGroup ? (
        <div className="mt-4">
          <div className="text-sm font-semibold mb-2">Members</div>
          <div className="space-y-2 max-h-52 overflow-auto pr-1">
            {data.members.map(m => (
              <div key={m.id} className="card p-3">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="font-medium">{m.name}</div>
                    <div className="text-xs text-gray-400">Public ID: {m.id}</div>
                  </div>
                  <span className="badge bg-purple-500/20 text-purple-300">Member</span>
                </div>
              </div>
            ))}
          </div>
        </div>
      ) : null}
    </div>
  )
}
