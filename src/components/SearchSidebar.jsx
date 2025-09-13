import React, { useState } from 'react'

export default function SearchSidebar({ onSearchGroupId, onSearchUserId, nearbyCount }) {
  const [groupId, setGroupId] = useState('')
  const [userId, setUserId] = useState('')

  return (
    <div>
      <h2 className="text-base font-semibold mb-3">Search</h2>
      <div className="space-y-4">
        <div>
          <label className="block text-xs text-gray-300 mb-1">Search by Group ID</label>
          <div className="flex gap-2">
            <input className="input" value={groupId} onChange={(e) => setGroupId(e.target.value)} placeholder="e.g., TESFF95A" />
            <button className="btn" onClick={() => onSearchGroupId(groupId)}>Find</button>
          </div>
        </div>
        <div>
          <label className="block text-xs text-gray-300 mb-1">Search by Public ID</label>
          <div className="flex gap-2">
            <input className="input" value={userId} onChange={(e) => setUserId(e.target.value)} placeholder="e.g., USOR7QNK" />
            <button className="btn" onClick={() => onSearchUserId(userId)}>Find</button>
          </div>
        </div>
      </div>
      <div className="mt-6">
        <div className="card p-3 text-center">
          <div className="text-xs text-gray-400">Nearby groups</div>
          <div className="text-2xl font-semibold">{nearbyCount ?? 0}</div>
        </div>
      </div>
    </div>
  )
}
