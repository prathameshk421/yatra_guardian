import React from 'react'
import { useNavigate } from 'react-router-dom'

export default function EFIRModal({ efirs = [], onLocate }) {
  const navigate = useNavigate()
  const close = () => navigate('/')

  return (
    <div className="fixed inset-0 z-40">
      <div className="absolute inset-0 bg-black/70 backdrop-blur-sm" onClick={close} />
      <div className="relative z-50 max-w-4xl mx-auto mt-8 mb-8 bg-black/80 border border-white/10 rounded-xl shadow-card overflow-hidden">
        <div className="px-4 py-3 border-b border-white/10 flex items-center justify-between">
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
        <div className="p-4 max-h-[80vh] overflow-auto space-y-3">
          {efirs?.length ? efirs.map(f => (
            <div key={f.id} className="card p-4">
              <div className="flex items-start justify-between gap-4">
                <div>
                  <div className="font-medium">{f.title}</div>
                  <div className="text-xs text-gray-400">FIR ID: {f.id} • {new Date(f.ts).toLocaleString()}</div>
                  <div className="mt-1 text-sm">By: {f.name} ({f.userId})</div>
                  <div className="mt-1 text-sm text-gray-300">{f.description}</div>
                  <div className="mt-1 text-xs text-gray-400">Location: {f.location?.map(n => n.toFixed(3)).join(', ')}</div>
                </div>
                <div className="flex flex-col items-end gap-2">
                  <span className={`badge ${f.status === 'Submitted' ? 'bg-blue-500/20 text-blue-300' : 'bg-amber-500/20 text-amber-300'}`}>{f.status}</span>
                  <button className="btn" onClick={() => onLocate?.(f.location)}>Locate</button>
                </div>
              </div>
            </div>
          )) : (
            <div className="text-sm text-gray-400">No E-FIRs available.</div>
          )}
        </div>
      </div>
    </div>
  )
}
