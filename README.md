# Police Dashboard (Vite + React + Tailwind)

Features:

- Dark UI with cards and badges
- World map (Leaflet) with heatmap overlay
- Search by Group ID and User ID
- Click on map to list groups near that location
- Results show Group/Solo with tags; clicking shows details and members
- Notifications panel with a simulated "I need help" alert button

## Scripts

- `npm run dev` – start development server
- `npm run build` – production build
- `npm run preview` – preview build

## Setup

1. Install dependencies

```powershell
npm install
```

2. Run dev server

```powershell
npm run dev
```

3. Open the printed local URL in your browser.

## Notes

- Map tiles use CartoDB dark tiles for contrast.
- Heatmap points are mock data in `src/data/mockData.js`.
- Search helpers in `src/utils/search.js`.
