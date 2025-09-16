// Reproducible tourist dataset (~240 entries) spread across major Indian cities
// Each tourist: { id: 'TRxxxxx', location: [lat, lng], name }

// Simple seeded PRNG for stable coordinates
function lcg(seed) {
  let s = seed >>> 0
  return function rand() {
    // Numerical Recipes LCG
    s = (1664525 * s + 1013904223) >>> 0
    return s / 0xffffffff
  }
}

const rand = lcg(20250916)

const cities = [
  { code: 'DEL', name: 'Delhi', loc: [28.6139, 77.2090], count: 24 },
  { code: 'MUM', name: 'Mumbai', loc: [19.0760, 72.8777], count: 24 },
  { code: 'BLR', name: 'Bengaluru', loc: [12.9716, 77.5946], count: 24 },
  { code: 'JAI', name: 'Jaipur', loc: [26.9124, 75.7873], count: 16 },
  { code: 'KOL', name: 'Kolkata', loc: [22.5726, 88.3639], count: 16 },
  { code: 'CHE', name: 'Chennai', loc: [13.0827, 80.2707], count: 16 },
  { code: 'HYD', name: 'Hyderabad', loc: [17.3850, 78.4867], count: 16 },
  { code: 'PUN', name: 'Pune', loc: [18.5204, 73.8567], count: 14 },
  { code: 'AHM', name: 'Ahmedabad', loc: [23.0225, 72.5714], count: 12 },
  { code: 'GOA', name: 'Goa', loc: [15.4909, 73.8278], count: 12 },
  { code: 'VAR', name: 'Varanasi', loc: [25.3176, 82.9739], count: 12 },
  { code: 'KOC', name: 'Kochi', loc: [9.9312, 76.2673], count: 12 },
  { code: 'SIM', name: 'Shimla', loc: [31.1048, 77.1734], count: 10 },
  { code: 'MAN', name: 'Manali', loc: [32.2432, 77.1892], count: 10 },
  { code: 'UDA', name: 'Udaipur', loc: [24.5854, 73.7125], count: 10 },
  { code: 'AGR', name: 'Agra', loc: [27.1767, 78.0081], count: 12 },
]

function jitterCoord([lat, lng]) {
  // Random offset up to ~1.5km radius; vary a bit per point
  // 1 degree lat ~ 111km, 1 degree lng ~ 111km * cos(lat)
  const r = (0.2 + rand() * 0.8) // 0.2..1.0 scale
  const maxKm = 1.5 * r
  const theta = rand() * Math.PI * 2
  const dxKm = Math.cos(theta) * maxKm
  const dyKm = Math.sin(theta) * maxKm
  const dLat = dyKm / 111
  const dLng = dxKm / (111 * Math.cos((lat * Math.PI) / 180))
  return [lat + dLat, lng + dLng]
}

function pad(n, len = 5) {
  return String(n).padStart(len, '0')
}

const firstNames = ['Aarav','Vihaan','Vivaan','Ananya','Diya','Ishaan','Kabir','Aditya','Aisha','Meera','Rohan','Riya','Arjun','Priya','Rahul','Neha','Karan','Pooja','Ritika','Vikram','Anita','Sanjay','Simran','Vikash','Naman','Aarohi','Akash','Sneha','Gaurav']
const lastNames = ['Sharma','Verma','Patel','Khan','Singh','Joshi','Mehta','Rao','Kumar','Jain','Gupta','Chopra','Kapoor','Roy','Ghosh','Iyer','Pillai','Das','Yadav','Bansal']

const tourists = []
let serial = 1

for (const city of cities) {
  for (let i = 0; i < city.count; i++) {
    const loc = jitterCoord(city.loc)
    const fn = firstNames[Math.floor(rand() * firstNames.length)]
    const ln = lastNames[Math.floor(rand() * lastNames.length)]
    tourists.push({
      id: `${city.code}-TR${pad(serial++)}`,
      name: `${fn} ${ln}`,
      location: [Number(loc[0].toFixed(6)), Number(loc[1].toFixed(6))],
      city: city.name,
    })
  }
}

// Ensure count ~240
// console.log('tourists count', tourists.length)

export default tourists
export { tourists }
