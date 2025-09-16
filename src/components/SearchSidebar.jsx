import React, { useState } from 'react'

export default function SearchSidebar({ onSearchGroupId, onSearchUserId, onSearchTouristId, nearbyCount }) {
  const [groupId, setGroupId] = useState('')
  const [userId, setUserId] = useState('')
  const [touristId, setTouristId] = useState('')

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
        <div>
          <label className="block text-xs text-gray-300 mb-1">Locate Tourist by ID</label>
          <div className="flex gap-2">
            <input className="input" value={touristId} onChange={(e) => setTouristId(e.target.value)} placeholder="e.g., DEL-TR0001" />
            <button className="btn" onClick={() => onSearchTouristId?.(touristId)}>Locate</button>
          </div>
          <div className="text-[10px] text-gray-400 mt-1">Tip: IDs look like DEL-TR0001, MUM-TR0035, BLR-TR0060…</div>
        </div>
      </div>
    </div>
  )
}
