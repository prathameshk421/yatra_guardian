import React from 'react'

export default function NotificationsPanel({ notifications, onLocate }) {
  return (
    <div>
      <div className="flex items-center justify-between mb-3">
        <h2 className="text-base font-semibold">Notifications</h2>
      </div>
      <div className="space-y-2 max-h-64 overflow-auto pr-1">
        {notifications?.length ? notifications.map(n => (
          <div key={n.id} className="card p-3">
            <div className="flex items-start justify-between gap-3">
              <div>
                <div className="text-sm">{n.message}</div>
                <div className="text-xs text-gray-400">{new Date(n.ts).toLocaleString()}</div>
              </div>
              <div className="flex items-center gap-2">
                <span className="badge bg-rose-500/20 text-rose-300">{n.type}</span>
                <button className="btn" onClick={() => onLocate?.(n.location)}>Locate</button>
              </div>
            </div>
          </div>
        )) : (
          <div className="text-sm text-gray-400">No notifications yet.</div>
        )}
      </div>
    </div>
  )
}
