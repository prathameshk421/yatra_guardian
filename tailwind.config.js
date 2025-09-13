/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{js,jsx,ts,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        background: '#000000',
        navbar: '#0b1220',
        card: '#0f172a',
        accent: '#38bdf8',
      },
      boxShadow: {
        card: '0 10px 15px -3px rgba(0,0,0,0.5), 0 4px 6px -2px rgba(0,0,0,0.3)'
      }
    },
  },
  plugins: [],
}
