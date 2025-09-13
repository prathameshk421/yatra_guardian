import React from 'react'

export default function IntroSplash({ fadingOut = false }) {
  return (
    <div className={`fixed inset-0 z-50 flex items-center justify-center bg-black/90 backdrop-blur-sm transition-opacity duration-700 ${fadingOut ? 'opacity-0' : 'opacity-100'}`}>
      <div className="flex flex-col items-center gap-6">
        {/* Rotating globe (bigger) */}
        <div className="relative w-56 h-56 sm:w-64 sm:h-64 md:w-72 md:h-72">
          {/* outer glow */}
          <div className="absolute -inset-6 rounded-full blur-2xl" style={{ background: 'radial-gradient(closest-side, rgba(56,189,248,0.15), transparent 70%)' }} />
          <div className="absolute inset-0 rounded-full bg-gradient-to-br from-white/10 to-white/5 border border-white/10 shadow-card" />
          {/* Meridians / parallels */}
          <div className="absolute inset-0 rounded-full border border-white/10 animate-spin-slow" />
          <div className="absolute inset-2 rounded-full border border-white/10 opacity-60 animate-spin-slower" />
          <div className="absolute inset-4 rounded-full border border-white/10 opacity-40 animate-spin-slowest" />

          {/* Orbiting dots at different radii/speeds */}
          <div className="absolute inset-0 animate-orbit-fast">
            <div className="absolute left-1/2 -translate-x-1/2 top-0 w-2.5 h-2.5 rounded-full bg-emerald-400 shadow-[0_0_12px_rgba(16,185,129,0.9)]" />
          </div>
          <div className="absolute inset-1 animate-orbit">
            <div className="absolute left-1/2 -translate-x-1/2 bottom-0 w-2 h-2 rounded-full bg-rose-400 shadow-[0_0_12px_rgba(244,63,94,0.9)]" />
          </div>
          <div className="absolute inset-3 animate-orbit-mid">
            <div className="absolute left-1/2 -translate-x-1/2 top-0 w-1.5 h-1.5 rounded-full bg-emerald-300 shadow-[0_0_8px_rgba(110,231,183,0.9)]" />
          </div>

          {/* Center shield pulse */}
          <div className="absolute inset-0 grid place-items-center">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-accent/30 to-white/10 border border-accent/40 grid place-items-center animate-center-pulse">
              <span className="text-accent text-xl">🛡️</span>
            </div>
          </div>
        </div>
        <div className="text-sm sm:text-base font-medium text-gray-200 tracking-wide animate-fade-up">Police Dashboard</div>
      </div>
    </div>
  )
}
