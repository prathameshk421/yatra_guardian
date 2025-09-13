import React from 'react'

export default function ResultsPanel({ results, onSelect }) {
  return (
    <div>
      <div className="flex items-center justify-between mb-2">
        <h2 className="text-base font-semibold">Results</h2>
        <span className="text-xs text-gray-400">{results?.length || 0} found</span>
      </div>
      <div className="space-y-2 max-h-64 overflow-auto pr-1">
        {results?.length ? results.map((g) => (
          <button key={g.id} onClick={() => onSelect(g)} className="w-full text-left card p-3 hover:bg-white/10 transition">
            <div className="flex items-center justify-between">
              <div>
                <div className="font-medium">{g.name}</div>
                <div className="text-xs text-gray-400">{g.type === 'group' ? 'Group ID' : 'Public ID'}: {g.id}</div>
              </div>
              <span className={`badge ${g.type === 'group' ? 'bg-blue-500/20 text-blue-300' : 'bg-emerald-500/20 text-emerald-300'}`}>{g.type === 'group' ? 'Group' : 'Solo'}</span>
            </div>
          </button>
        )) : (
          <div className="text-sm text-gray-400">No results yet. Search by ID or click on the map.</div>
        )}
      </div>
    </div>
  )
}
