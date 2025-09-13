// Haversine distance in km
function haversine(a, b) {
  const toRad = (x) => (x * Math.PI) / 180
  const [lat1, lon1] = a
  const [lat2, lon2] = b
  const R = 6371
  const dLat = toRad(lat2 - lat1)
  const dLon = toRad(lon2 - lon1)
  const A =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
    Math.sin(dLon / 2) * Math.sin(dLon / 2)
  const c = 2 * Math.atan2(Math.sqrt(A), Math.sqrt(1 - A))
  return R * c
}

export function findByGroupId(groups, id) {
  const idNorm = id.trim().toLowerCase()
  if (!idNorm) return []
  return groups.filter(g => g.id.toLowerCase() === idNorm)
}

export function findByUserId(groups, userId) {
  const idNorm = userId.trim().toLowerCase()
  if (!idNorm) return []
  const res = []
  for (const g of groups) {
    if (g.type === 'solo' && g.id.toLowerCase() === idNorm) res.push(g)
    if (g.type === 'group' && g.members?.some(m => m.id.toLowerCase() === idNorm)) res.push(g)
  }
  return res
}

export function findNearbyGroups(groups, latlng, radiusKm = 25) {
  const res = []
  for (const g of groups) {
    if (haversine(g.lastLocation, latlng) <= radiusKm) res.push(g)
  }
  return res
}
