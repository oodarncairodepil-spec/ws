# Whiteout Survival Companion App

A comprehensive mobile-first companion application for the Whiteout Survival game, featuring real-time data management, strategic recommendations, and cloud synchronization.

## 🚀 Features

### Core Functionality
- **Player Data Management**: Track player stats, level, power, and alliance information
- **Building Management**: Monitor and optimize building levels and upgrades
- **Resource Tracking**: Real-time resource monitoring with production calculations
- **Research Progress**: Track research levels and plan upgrade paths
- **Goal Setting**: Set and track personal game objectives

### Advanced Features
- **Strategy Recommendations**: AI-powered suggestions for optimal gameplay
- **Cloud Synchronization**: Automatic data backup with Supabase integration
- **Mobile-First Design**: Responsive UI optimized for mobile devices
- **Offline Support**: Local data storage when offline
- **Data Import/Export**: Backup and restore game data

### Technical Features
- **Real-time Calculations**: Advanced game mechanics calculations
- **Database Testing**: Built-in connection and functionality testing
- **Auto-save**: Automatic cloud synchronization every 30 seconds
- **Performance Optimized**: Fast loading and smooth interactions

## 🛠️ Technology Stack

- **Frontend**: React 18 with Vite
- **Styling**: Tailwind CSS with custom mobile optimizations
- **Database**: Supabase (PostgreSQL)
- **State Management**: React Context API
- **Build Tool**: Vite
- **Linting**: ESLint

## 📱 Mobile Optimization

- Touch-friendly interface with minimum 44px touch targets
- Responsive grid layouts that adapt to screen sizes
- Mobile navigation with tab-based interface
- Optimized typography and spacing for mobile devices
- Swipe gestures and mobile-specific interactions

## 🗄️ Database Schema

The application uses the following main tables:
- `players`: User profiles and basic stats
- `game_states`: Complete game state snapshots
- `buildings`: Building reference data
- `resources`: Resource type definitions
- `strategies`: Saved strategy recommendations

## 🚀 Getting Started

### Prerequisites
- Node.js 18+ 
- npm or yarn
- Supabase account (for cloud features)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd WhiteOut
   ```

2. **Install dependencies**
   ```bash
   npm install
   # or
   yarn install
   ```

3. **Set up Supabase** (Optional - app works offline without this)
   - Create a new Supabase project
   - Run the SQL script from `database/setup.sql` in your Supabase SQL editor
   - Update `src/lib/supabase.js` with your project credentials (already configured)

4. **Start the development server**
   ```bash
   npm run dev
   # or
   yarn dev
   ```

5. **Open the application**
   - Navigate to `http://localhost:5174`
   - The app is mobile-optimized, so try it on your phone or use browser dev tools

### Building for Production

```bash
npm run build
# or
yarn build
```

The built files will be in the `dist/` directory, ready for deployment to any static hosting service.

## 📖 Usage Guide

### Getting Started
1. **Enter Player Data**: Start by inputting your current player stats in the Data Input section
2. **Add Buildings**: Record your current building levels
3. **Track Resources**: Input your current resource amounts
4. **Set Goals**: Define what you want to achieve in the game

### Using Strategy Recommendations
1. Navigate to the Strategy tab
2. View AI-generated recommendations based on your current state
3. Filter recommendations by category (Building, Research, Resource)
4. Save useful strategies for later reference
5. Check the "Optimal Sequence" tab for upgrade prioritization

### Database Features
1. **Auto-save**: Enable in Database Status for automatic cloud backup
2. **Manual Sync**: Use Save/Load buttons for manual synchronization
3. **Export Data**: Download your game data as JSON backup
4. **Test Connection**: Verify database connectivity

## 🧪 Testing

### Linting
```bash
npm run lint
```

### Database Testing
The app includes built-in database testing:
1. Open the app and navigate to Data Input
2. Expand the Database Status section
3. Click "Test" for basic connection testing
4. Click "Run Full Test Suite" for comprehensive testing

### Manual Testing
1. Test mobile responsiveness using browser dev tools
2. Verify offline functionality by disconnecting internet
3. Test data import/export functionality
4. Validate calculation accuracy with known game values

## 🔧 Configuration

### Supabase Configuration
The app is pre-configured with Supabase credentials. For your own deployment:
1. Update `src/lib/supabase.js` with your project URL and anon key
2. Run the database setup script in your Supabase project
3. Configure Row Level Security policies as needed

### Customization
- **Styling**: Modify `src/index.css` for custom styles
- **Game Data**: Update constants in `src/utils/gameCalculations.js`
- **UI Components**: Customize components in `src/components/`

## 📁 Project Structure

```
src/
├── components/          # React components
│   ├── Dashboard.jsx    # Main dashboard
│   ├── DataInput.jsx    # Data input forms
│   ├── BuildingManager.jsx
│   ├── ResourceManager.jsx
│   ├── StrategyRecommendations.jsx
│   ├── DatabaseStatus.jsx
│   └── MobileNavigation.jsx
├── context/             # React Context
│   └── GameContext.tsx  # Game state management
├── hooks/               # Custom hooks
│   └── useDatabase.js   # Database operations
├── lib/                 # External libraries
│   └── supabase.js      # Supabase client
├── types/               # TypeScript definitions
│   └── gameData.ts      # Game data types
├── utils/               # Utility functions
│   ├── gameCalculations.js  # Game mechanics
│   └── testDatabase.js      # Database testing
└── App.jsx              # Main application
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Whiteout Survival game developers for creating an engaging survival strategy game
- Supabase for providing excellent backend-as-a-service
- React and Vite teams for amazing development tools
- Tailwind CSS for the utility-first CSS framework

## 📞 Support

If you encounter any issues or have questions:
1. Check the built-in database testing tools
2. Review the browser console for error messages
3. Ensure your Supabase configuration is correct
4. Try the app in offline mode to isolate connectivity issues

---

**Happy Gaming! 🎮❄️**
