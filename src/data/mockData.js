const groups = [
  {
    id: 'TESFF95A',
    type: 'group',
    name: 'Tour Group Himalaya',
    lastLocation: [28.6139, 77.2090], // Delhi
    members: [
      { id: 'USOR7QNK', name: 'Aisha Khan', phone: '+91 98765 43210', emergencyContact: '+91 91234 56789', email: 'aisha.k@example.com', nationality: 'Indian', address: 'Flat 12B, Connaught Place, New Delhi 110001', lastLocation: [28.61, 77.20] },
      { id: 'JNP6Z4HT', name: 'Ravi Patel', phone: '+91 99876 54321', emergencyContact: '+91 90123 45678', email: 'ravi.p@example.com', nationality: 'Indian', address: 'Sector 21, Dwarka, New Delhi 110075', lastLocation: [28.63, 77.22] },
      { id: 'K0ZTB4MV', name: 'Meera Joshi', phone: '+91 90909 10101', emergencyContact: '+91 98000 11111', email: 'meera.j@example.com', nationality: 'Indian', address: 'Karol Bagh, New Delhi 110005', lastLocation: [28.60, 77.21] },
    ],
  },
  {
    id: 'DELHI002',
    type: 'group',
    name: 'Delhi City Walk',
    lastLocation: [28.65, 77.23],
    members: [
      { id: 'A1B2C3D4', name: 'Naman Gupta', phone: '+91 99100 20030', emergencyContact: '+91 98999 88998', email: 'naman.g@example.com', nationality: 'Indian', address: 'Rohini, Delhi 110085', lastLocation: [28.72, 77.12] },
      { id: 'E5F6G7H8', name: 'Simran Kaur', phone: '+91 98100 77889', emergencyContact: '+91 98710 33557', email: 'simran.k@example.com', nationality: 'Indian', address: 'Saket, Delhi 110017', lastLocation: [28.52, 77.20] },
    ],
  },
  {
    id: 'KJXPA83M',
    type: 'group',
    name: 'Jaipur Heritage Tour',
    lastLocation: [26.9124, 75.7873],
    members: [
      { id: 'H3W29NQF', name: 'Arjun Singh', phone: '+91 99880 11223', emergencyContact: '+91 98765 00000', email: 'arjun.s@example.com', nationality: 'Indian', address: 'MI Road, Jaipur 302001', lastLocation: [26.91, 75.78] },
      { id: 'P7L2Q9SX', name: 'Priya Verma', phone: '+91 90000 11111', emergencyContact: '+91 95555 22222', email: 'priya.v@example.com', nationality: 'Indian', address: 'C-Scheme, Jaipur 302005', lastLocation: [26.92, 75.79] },
    ],
  },
  {
    id: 'JAIPUR03',
    type: 'group',
    name: 'Pink City Discovery',
    lastLocation: [26.92, 75.80],
    members: [
      { id: 'R2S3T4U5', name: 'Rohit Sharma', phone: '+91 97979 12345', emergencyContact: '+91 97111 55667', email: 'rohit.s@example.com', nationality: 'Indian', address: 'Malviya Nagar, Jaipur 302017', lastLocation: [26.86, 75.82] },
      { id: 'V7W8X9Y0', name: 'Pooja Jain', phone: '+91 98292 33445', emergencyContact: '+91 98989 77665', email: 'pooja.j@example.com', nationality: 'Indian', address: 'Vaishali Nagar, Jaipur 302021', lastLocation: [26.92, 75.72] },
    ],
  },
  {
    id: 'MUMBAI01',
    type: 'group',
    name: 'Mumbai City Tour',
    lastLocation: [19.0760, 72.8777], // Mumbai
    members: [
      { id: 'Q9L7T3AZ', name: 'Sanjay Mehta', phone: '+91 98200 12345', emergencyContact: '+91 98190 54321', email: 'sanjay.m@example.com', nationality: 'Indian', address: 'Andheri West, Mumbai 400053', lastLocation: [19.11, 72.84] },
      { id: 'V6C2K8RM', name: 'Ritika Shah', phone: '+91 99300 11223', emergencyContact: '+91 90040 55667', email: 'ritika.s@example.com', nationality: 'Indian', address: 'Powai, Mumbai 400076', lastLocation: [19.12, 72.90] },
    ],
  },
  {
    id: 'BLRTOUR1',
    type: 'group',
    name: 'Bengaluru Explorer',
    lastLocation: [12.9716, 77.5946], // Bengaluru
    members: [
      { id: 'ZX4N7BQP', name: 'Anita Rao', phone: '+91 98450 22334', emergencyContact: '+91 98860 44556', email: 'anita.r@example.com', nationality: 'Indian', address: 'Koramangala, Bengaluru 560095', lastLocation: [12.95, 77.62] },
      { id: 'TS8M1JLK', name: 'Vikram Kumar', phone: '+91 99000 77889', emergencyContact: '+91 99860 11223', email: 'vikram.k@example.com', nationality: 'Indian', address: 'Whitefield, Bengaluru 560066', lastLocation: [12.97, 77.74] },
    ],
  },
  {
    id: 'USOR7QNK',
    type: 'solo',
    name: 'Solo Traveler: Kabir', phone: '+91 98765 43211', emergencyContact: '+91 91234 56780', email: 'kabir.t@example.com', nationality: 'Indian', address: 'Bandra West, Mumbai 400050',
    lastLocation: [19.0760, 72.8777], // Mumbai
  },
  {
    id: 'AWZT4MDL',
    type: 'solo',
    name: 'Solo Traveler: Neha', phone: '+91 99876 54322', emergencyContact: '+91 90123 45679', email: 'neha.s@example.com', nationality: 'Indian', address: 'Indiranagar, Bengaluru 560038',
    lastLocation: [12.9716, 77.5946], // Bangalore
  },
]

// Heat points: array of [lat, lng, intensity]
// intensity optional; leaflet.heat uses [lat, lng, intensity]
const heatPoints = [
  [28.6139, 77.2090, 0.6],
  [26.9124, 75.7873, 0.5],
  [19.0760, 72.8777, 0.7],
  [12.9716, 77.5946, 0.7],
  [22.5726, 88.3639, 0.4],
  [13.0827, 80.2707, 0.3],
  [17.3850, 78.4867, 0.5],
]

const notifications = [
  {
    id: 'N-9001',
    type: 'help',
    message: 'AWZT4MDL (Neha) requested help',
    location: [12.9716, 77.5946],
    ts: new Date(Date.now() - 1000 * 60 * 45).toISOString(),
  },
]

// Sample E-FIR entries
const efirs = [
  {
    id: 'FIR-2025-0001',
    userId: 'USOR7QNK',
    name: 'Aisha Khan',
    title: 'Lost Passport',
    description: 'Reported loss of passport near Connaught Place.',
    location: [28.61, 77.20],
    status: 'Submitted',
    ts: new Date(Date.now() - 1000 * 60 * 60 * 5).toISOString(),
  },
  {
    id: 'FIR-2025-0002',
    userId: 'V6C2K8RM',
    name: 'Ritika Shah',
    title: 'Phone Snatched',
    description: 'Mobile phone snatched near Andheri station.',
    location: [19.11, 72.84],
    status: 'In Review',
    ts: new Date(Date.now() - 1000 * 60 * 120).toISOString(),
  },
]

export default { groups, heatPoints, notifications, efirs }
