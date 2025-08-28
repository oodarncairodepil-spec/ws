-- Whiteout Survival Companion App Database Setup
-- Run this script in your Supabase SQL editor

-- Create players table
CREATE TABLE IF NOT EXISTS players (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  username VARCHAR(50) UNIQUE NOT NULL,
  level INTEGER DEFAULT 1,
  power BIGINT DEFAULT 0,
  alliance VARCHAR(100),
  server VARCHAR(50),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create game_states table
CREATE TABLE IF NOT EXISTS game_states (
  id VARCHAR(50) PRIMARY KEY DEFAULT 'default',
  player_id UUID REFERENCES players(id) ON DELETE CASCADE,
  player_data JSONB NOT NULL DEFAULT '{}',
  buildings_data JSONB NOT NULL DEFAULT '{}',
  research_data JSONB NOT NULL DEFAULT '{}',
  goals_data JSONB NOT NULL DEFAULT '[]',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create buildings table for reference data
CREATE TABLE IF NOT EXISTS buildings (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  type VARCHAR(50) NOT NULL,
  base_cost JSONB NOT NULL DEFAULT '{}',
  base_power INTEGER DEFAULT 0,
  max_level INTEGER DEFAULT 50,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create building levels table for detailed level data
CREATE TABLE IF NOT EXISTS building_levels (
  id SERIAL PRIMARY KEY,
  building_name VARCHAR(100) NOT NULL,
  level INTEGER NOT NULL,
  prerequisites VARCHAR(200),
  build_cost JSONB NOT NULL DEFAULT '{}',
  construction_time VARCHAR(50),
  building_power INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(building_name, level)
);

-- Create resources table for reference data
CREATE TABLE IF NOT EXISTS resources (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  type VARCHAR(30) NOT NULL,
  icon VARCHAR(100),
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create strategies table
CREATE TABLE IF NOT EXISTS strategies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  player_id UUID REFERENCES players(id) ON DELETE CASCADE,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  category VARCHAR(50) NOT NULL,
  priority VARCHAR(20) DEFAULT 'medium',
  requirements JSONB DEFAULT '{}',
  steps JSONB DEFAULT '[]',
  is_completed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create heroes table
CREATE TABLE IF NOT EXISTS heroes (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  role VARCHAR(50) NOT NULL,
  rarity VARCHAR(20) NOT NULL,
  generation VARCHAR(50) NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create hero upgrade costs table
CREATE TABLE IF NOT EXISTS hero_upgrade_costs (
  id SERIAL PRIMARY KEY,
  star_level INTEGER NOT NULL,
  tier_level INTEGER NOT NULL,
  shards_required INTEGER NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(star_level, tier_level)
);

-- Insert default resource types
INSERT INTO resources (name, type, description) VALUES
('Food', 'basic', 'Essential resource for survivor maintenance'),
('Wood', 'basic', 'Basic building material'),
('Iron', 'basic', 'Metal resource for construction and equipment'),
('Stone', 'basic', 'Stone resource for advanced buildings'),
('Coal', 'advanced', 'Energy resource for heating and power'),
('Steel', 'advanced', 'Advanced metal for high-tier buildings'),
('Plastic', 'advanced', 'Modern material for specialized equipment'),
('Electronic Components', 'advanced', 'High-tech components for advanced research'),
('Gems', 'premium', 'Premium currency for speedups and purchases')
ON CONFLICT (name) DO NOTHING;

-- Insert default building types
INSERT INTO buildings (name, type, base_cost, base_power, max_level, description) VALUES
('Furnace', 'core', '{"meat": 60}', 440, 30, 'Core building that provides heating and basic power'),
('Coal Mine', 'production', '{"wood": 30}', 40, 30, 'Produces coal resources'),
('Iron Mine', 'production', '{"wood": 30}', 40, 30, 'Produces iron resources'),
('Research Center', 'research', '{"wood": 105}', 440, 30, 'Unlocks new technologies and upgrades'),
('Command Center', 'military', '{"wood": 80}', 280, 30, 'Military command and coordination center'),
('Embassy', 'diplomatic', '{"wood": 60}', 440, 30, 'Diplomatic building for alliances'),
('Infirmary', 'support', '{}', 300, 30, 'Heals injured survivors'),
('Marksman Camp', 'military', '{"wood": 95}', 400, 30, 'Training facility for marksmen'),
('Storehouse', 'storage', '{"wood": 60}', 440, 30, 'Storage facility for resources'),
('Barricade', 'defense', '{}', 400, 10, 'Defensive structure for protection')
ON CONFLICT DO NOTHING;

-- Insert heroes data
INSERT INTO heroes (name, role, rarity, generation) VALUES
-- Generation 1 Mythic
('Jeronimo', 'Infantry', 'Mythic (SSR)', 'Generation 1'),
('Natalia', 'Infantry', 'Mythic (SSR)', 'Generation 1'),
('Molly', 'Lancer', 'Mythic (SSR)', 'Generation 1'),
('Zinman', 'Marksman', 'Mythic (SSR)', 'Generation 1'),
-- Generation 1 Epic
('Sergey', 'Infantry', 'Epic (SR)', 'Generation 1'),
('Patrick', 'Infantry', 'Epic (SR)', 'Generation 1'),
('Jessie', 'Lancer', 'Epic (SR)', 'Generation 1'),
('Bahiti', 'Marksman', 'Epic (SR)', 'Generation 1'),
('Gina', 'Marksman', 'Epic (SR)', 'Generation 1'),
('Lumak Bokan', 'Lancer', 'Epic (SR)', 'Generation 1'),
('Jasser', 'Marksman', 'Epic (SR)', 'Generation 1'),
('Seo-yoon', 'Marksman', 'Epic (SR)', 'Generation 1'),
('Ling Xue', 'Lancer', 'Epic (SR)', 'Generation 1'),
-- Generation 1 Rare
('Smith', 'Infantry', 'Rare (R)', 'Generation 1'),
('Eugene', 'Infantry', 'Rare (R)', 'Generation 1'),
('Charlie', 'Lancer', 'Rare (R)', 'Generation 1'),
('Cloris', 'Marksman', 'Rare (R)', 'Generation 1'),
-- Generation 2
('Flint', 'Infantry', 'Mythic (SSR)', 'Generation 2'),
('Philly', 'Lancer', 'Mythic (SSR)', 'Generation 2'),
('Alonso', 'Marksman', 'Mythic (SSR)', 'Generation 2'),
-- Generation 3
('Logan', 'Infantry', 'Mythic (SSR)', 'Generation 3'),
('Mia', 'Lancer', 'Mythic (SSR)', 'Generation 3'),
('Greg', 'Marksman', 'Mythic (SSR)', 'Generation 3'),
-- Generation 4
('Ahmose', 'Infantry', 'Mythic (SSR)', 'Generation 4'),
('Reina', 'Lancer', 'Mythic (SSR)', 'Generation 4'),
('Lynn', 'Marksman', 'Mythic (SSR)', 'Generation 4'),
-- Generation 5
('Hector', 'Infantry', 'Mythic (SSR)', 'Generation 5'),
('Norah', 'Lancer', 'Mythic (SSR)', 'Generation 5'),
('Gwen', 'Marksman', 'Mythic (SSR)', 'Generation 5'),
-- Generation 6
('Wu Ming', 'Infantry', 'Mythic (SSR)', 'Generation 6'),
('Renee', 'Lancer', 'Mythic (SSR)', 'Generation 6'),
('Wayne', 'Marksman', 'Mythic (SSR)', 'Generation 6'),
-- Generation 7
('Edith', 'Infantry', 'Mythic (SSR)', 'Generation 7'),
('Gordon', 'Lancer', 'Mythic (SSR)', 'Generation 7'),
('Bradley', 'Marksman', 'Mythic (SSR)', 'Generation 7'),
-- Generation 8
('Gatot', 'Infantry', 'Mythic (SSR)', 'Generation 8'),
('Sonya', 'Lancer', 'Mythic (SSR)', 'Generation 8'),
('Hendrik', 'Marksman', 'Mythic (SSR)', 'Generation 8'),
-- Generation 9
('Magnus', 'Infantry', 'Mythic (SSR)', 'Generation 9'),
('Fred', 'Lancer', 'Mythic (SSR)', 'Generation 9'),
('Xura', 'Marksman', 'Mythic (SSR)', 'Generation 9'),
-- Season 10
('Gregory', 'Infantry', 'Mythic (SSR)', 'Season 10'),
('Freya', 'Lancer', 'Mythic (SSR)', 'Season 10'),
('Blanchette', 'Marksman', 'Mythic (SSR)', 'Season 10'),
-- Season 11
('Eleonora', 'Infantry', 'Mythic (SSR)', 'Season 11'),
('Lloyd', 'Lancer', 'Mythic (SSR)', 'Season 11'),
('Rufus', 'Marksman', 'Mythic (SSR)', 'Season 11'),
-- Season 12
('Hervor', 'Infantry', 'Mythic (SSR)', 'Season 12'),
('Karol', 'Lancer', 'Mythic (SSR)', 'Season 12'),
('Ligeia', 'Marksman', 'Mythic (SSR)', 'Season 12'),
-- Season 13
('Gisela', 'Infantry', 'Mythic (SSR)', 'Season 13'),
('Flora', 'Lancer', 'Mythic (SSR)', 'Season 13'),
('Vulcanus', 'Marksman', 'Mythic (SSR)', 'Season 13')
ON CONFLICT (name) DO NOTHING;

-- Insert hero upgrade costs
INSERT INTO hero_upgrade_costs (star_level, tier_level, shards_required) VALUES
-- 1 Star
(1, 0, 0), (1, 1, 11), (1, 2, 1), (1, 3, 2), (1, 4, 2), (1, 5, 2), (1, 6, 2),
-- 2 Star
(2, 0, 0), (2, 1, 5), (2, 2, 5), (2, 3, 5), (2, 4, 5), (2, 5, 5), (2, 6, 15),
-- 3 Star
(3, 0, 0), (3, 1, 15), (3, 2, 15), (3, 3, 15), (3, 4, 15), (3, 5, 15), (3, 6, 40),
-- 4 Star
(4, 0, 0), (4, 1, 40), (4, 2, 40), (4, 3, 40), (4, 4, 40), (4, 5, 40), (4, 6, 100),
-- 5 Star
(5, 0, 0), (5, 1, 100), (5, 2, 100), (5, 3, 100), (5, 4, 100), (5, 5, 100), (5, 6, 100)
ON CONFLICT (star_level, tier_level) DO NOTHING;

-- Insert building level data
INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) VALUES
-- Barricade levels
('Barricade', 1, null, '{"Meat": 0, "Wood": 0, "Coal": 0, "Iron": 0}', '0:00:00', 400),
('Barricade', 2, 'Furnace Lv. 7', '{"Meat": 0, "Wood": 5300, "Coal": 1000, "Iron": 0}', '0:00:10', 3100),
('Barricade', 3, 'Furnace Lv. 10', '{"Meat": 0, "Wood": 88000, "Coal": 17000, "Iron": 4400}', '0:21:30', 9400),
('Barricade', 4, 'Furnace Lv. 13', '{"Meat": 0, "Wood": 420000, "Coal": 420000, "Iron": 84000, "Steel": 21000}', '1:04:30', 21940),
('Barricade', 5, 'Furnace Lv. 16', '{"Meat": 0, "Wood": 1400000, "Coal": 1400000, "Iron": 290000, "Steel": 74000}', '3:39:00', 47240),
('Barricade', 6, 'Furnace Lv. 20', '{"Meat": 0, "Wood": 5300000, "Coal": 5300000, "Iron": 1000000, "Steel": 260000}', '9:52:30', 86360),
('Barricade', 7, 'Furnace Lv. 24', '{"Meat": 0, "Wood": 15000000, "Coal": 15000000, "Iron": 3000000, "Steel": 750000}', '1d 13:44:00', 149500),
('Barricade', 8, 'Furnace Lv. 27', '{"Meat": 0, "Wood": 37000000, "Coal": 37000000, "Iron": 7400000, "Steel": 1800000}', '3d 00:55:00', 217320),
('Barricade', 9, 'Furnace Lv. 29', '{"Meat": 0, "Wood": 61000000, "Coal": 61000000, "Iron": 12000000, "Steel": 3000000}', '4d 00:26:00', 267920),
('Barricade', 10, 'Furnace Lv. 30', '{"Meat": 0, "Wood": 75000000, "Coal": 75000000, "Iron": 15000000, "Steel": 3700000}', '4d 19:44:00', 304700),
-- Coal Mine levels
('Coal Mine', 1, 'Furnace Lv. 3', '{"Meat": 0, "Wood": 30, "Coal": 0, "Iron": 0}', '0:00:02', 40),
('Coal Mine', 2, 'Furnace Lv. 3', '{"Meat": 0, "Wood": 45, "Coal": 0, "Iron": 0}', '0:00:03', 76),
('Coal Mine', 3, 'Furnace Lv. 3', '{"Meat": 0, "Wood": 200, "Coal": 0, "Iron": 0}', '0:00:10', 130),
('Coal Mine', 4, 'Furnace Lv. 4', '{"Meat": 0, "Wood": 450, "Coal": 90, "Iron": 0}', '0:00:35', 202),
('Coal Mine', 5, 'Furnace Lv. 5', '{"Meat": 0, "Wood": 1900, "Coal": 380, "Iron": 0}', '0:01:10', 310),
('Coal Mine', 6, 'Furnace Lv. 6', '{"Meat": 0, "Wood": 4800, "Coal": 960, "Iron": 240}', '0:02:20', 472),
('Coal Mine', 7, 'Furnace Lv. 7', '{"Meat": 0, "Wood": 17000, "Coal": 3400, "Iron": 865}', '0:04:45', 706),
('Coal Mine', 8, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 31000, "Coal": 6300, "Iron": 1500}', '0:07:10', 940),
('Coal Mine', 9, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 65000, "Coal": 13000, "Iron": 3200}', '0:10:30', 1174),
('Coal Mine', 10, 'Furnace Lv. 10', '{"Meat": 0, "Wood": 110000, "Coal": 23000, "Iron": 5700}', '0:14:00', 1514),
('Coal Mine', 11, 'Furnace Lv. 11', '{"Meat": 110000, "Wood": 110000, "Coal": 23000, "Iron": 5900}', '0:18:00', 1854),
('Coal Mine', 12, 'Furnace Lv. 12', '{"Meat": 150000, "Wood": 150000, "Coal": 30000, "Iron": 7500}', '0:21:30', 2194),
('Coal Mine', 13, 'Furnace Lv. 13', '{"Meat": 210000, "Wood": 210000, "Coal": 42000, "Iron": 10000}', '0:26:00', 2768),
('Coal Mine', 14, 'Furnace Lv. 14', '{"Meat": 280000, "Wood": 280000, "Coal": 56000, "Iron": 14000}', '0:33:30', 3342),
('Coal Mine', 15, 'Furnace Lv. 15', '{"Meat": 410000, "Wood": 410000, "Coal": 83000, "Iron": 20000}', '0:43:00', 3916),
('Coal Mine', 16, 'Furnace Lv. 16', '{"Meat": 530000, "Wood": 530000, "Coal": 100000, "Iron": 26000}', '1:13:00', 4724),
('Coal Mine', 17, 'Furnace Lv. 17', '{"Meat": 830000, "Wood": 830000, "Coal": 160000, "Iron": 41000}', '1:27:30', 5532),
('Coal Mine', 18, 'Furnace Lv. 18', '{"Meat": 1100000, "Wood": 1100000, "Coal": 220000, "Iron": 56000}', '1:45:00', 6340),
('Coal Mine', 19, 'Furnace Lv. 19', '{"Meat": 1400000, "Wood": 1400000, "Coal": 280000, "Iron": 70000}', '2:38:00', 7488),
('Coal Mine', 20, 'Furnace Lv. 20', '{"Meat": 1900000, "Wood": 1900000, "Coal": 300000, "Iron": 96000}', '3:17:30', 8636),
('Coal Mine', 21, 'Furnace Lv. 21', '{"Meat": 2400000, "Wood": 2400000, "Coal": 490000, "Iron": 120000}', '4:16:30', 9784),
('Coal Mine', 22, 'Furnace Lv. 22', '{"Meat": 3200000, "Wood": 3200000, "Coal": 640000, "Iron": 160000}', '6:25:00', 11506),
('Coal Mine', 23, 'Furnace Lv. 23', '{"Meat": 4000000, "Wood": 4000000, "Coal": 800000, "Iron": 200000}', '8:59:00', 13228),
('Coal Mine', 24, 'Furnace Lv. 24', '{"Meat": 5400000, "Wood": 5400000, "Coal": 1000000, "Iron": 270000}', '12:34:30', 14950),
('Coal Mine', 25, 'Furnace Lv. 25', '{"Meat": 7300000, "Wood": 7300000, "Coal": 1400000, "Iron": 360000}', '17:36:30', 16672),
('Coal Mine', 26, 'Furnace Lv. 26', '{"Meat": 9400000, "Wood": 9400000, "Coal": 1800000, "Iron": 470000}', '20:15:00', 19202),
('Coal Mine', 27, 'Furnace Lv. 27', '{"Meat": 13000000, "Wood": 13000000, "Coal": 2600000, "Iron": 670000}', '1d 00:18:00', 21732),
('Coal Mine', 28, 'Furnace Lv. 28', '{"Meat": 17000000, "Wood": 17000000, "Coal": 3500000, "Iron": 890000}', '1d 03:57:00', 24262),
('Coal Mine', 29, 'Furnace Lv. 29', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4600000, "Iron": 1200000}', '1d 08:24:00', 26792),
('Coal Mine', 30, 'Furnace Lv. 30', '{"Meat": 30000000, "Wood": 30000000, "Coal": 6000000, "Iron": 1500000}', '1d 13:44:00', 29322),
-- Command Center levels (first 10 levels)
('Command Center', 1, 'Furnace Lv. 10, Embassy Lv. 1', '{"Meat": 0, "Wood": 80, "Coal": 0, "Iron": 0}', '0:00:02', 280),
('Command Center', 2, 'Furnace Lv. 10, Embassy Lv. 2', '{"Meat": 0, "Wood": 125, "Coal": 0, "Iron": 0}', '0:00:08', 532),
('Command Center', 3, 'Furnace Lv. 10, Embassy Lv. 3', '{"Meat": 0, "Wood": 565, "Coal": 0, "Iron": 0}', '0:00:35', 910),
('Command Center', 4, 'Furnace Lv. 10, Embassy Lv. 4', '{"Meat": 0, "Wood": 1200, "Coal": 250, "Iron": 0}', '0:01:45', 1414),
('Command Center', 5, 'Furnace Lv. 10, Embassy Lv. 5', '{"Meat": 0, "Wood": 5300, "Coal": 1000, "Iron": 0}', '0:03:35', 2170),
('Command Center', 6, 'Furnace Lv. 10, Embassy Lv. 6', '{"Meat": 0, "Wood": 13000, "Coal": 2600, "Iron": 670}', '0:07:10', 3304),
('Command Center', 7, 'Furnace Lv. 10, Embassy Lv. 7', '{"Meat": 0, "Wood": 48000, "Coal": 9600, "Iron": 2400}', '0:14:00', 4942),
('Command Center', 8, 'Furnace Lv. 10, Embassy Lv. 8', '{"Meat": 0, "Wood": 88000, "Coal": 17000, "Iron": 4400}', '0:21:00', 6580),
('Command Center', 9, 'Furnace Lv. 10, Embassy Lv. 9', '{"Meat": 0, "Wood": 180000, "Coal": 36000, "Iron": 9100}', '0:32:00', 8218),
('Command Center', 10, 'Furnace Lv. 10, Embassy Lv. 10', '{"Meat": 0, "Wood": 320000, "Coal": 64000, "Iron": 16000}', '0:43:00', 10598)
ON CONFLICT DO NOTHING;

-- Continue with more Command Center levels and other buildings
INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) VALUES
-- Command Center levels 11-20
('Command Center', 11, 'Furnace Lv. 11, Embassy Lv. 11', '{"Meat": 390000, "Wood": 390000, "Coal": 79000, "Iron": 19000}', '0:54:00', 12978),
('Command Center', 12, 'Furnace Lv. 12, Embassy Lv. 12', '{"Meat": 500000, "Wood": 500000, "Coal": 100000, "Iron": 25000}', '1:04:30', 15358),
('Command Center', 13, 'Furnace Lv. 13, Embassy Lv. 13', '{"Meat": 710000, "Wood": 710000, "Coal": 140000, "Iron": 35000}', '1:19:00', 19376),
('Command Center', 14, 'Furnace Lv. 14, Embassy Lv. 14', '{"Meat": 940000, "Wood": 940000, "Coal": 180000, "Iron": 47000}', '1:40:30', 23394),
('Command Center', 15, 'Furnace Lv. 15, Embassy Lv. 15', '{"Meat": 1300000, "Wood": 1300000, "Coal": 270000, "Iron": 69000}', '2:09:30', 27412),
('Command Center', 16, 'Furnace Lv. 16, Embassy Lv. 16', '{"Meat": 1700000, "Wood": 1700000, "Coal": 350000, "Iron": 89000}', '3:39:00', 33068),
('Command Center', 17, 'Furnace Lv. 17, Embassy Lv. 17', '{"Meat": 2700000, "Wood": 2700000, "Coal": 550000, "Iron": 130000}', '4:23:00', 38724),
('Command Center', 18, 'Furnace Lv. 18, Embassy Lv. 18', '{"Meat": 3700000, "Wood": 3700000, "Coal": 750000, "Iron": 180000}', '5:16:00', 44380),
('Command Center', 19, 'Furnace Lv. 19, Embassy Lv. 19', '{"Meat": 4700000, "Wood": 4700000, "Coal": 950000, "Iron": 240000}', '7:54:00', 52374),
('Command Center', 20, 'Furnace Lv. 20, Embassy Lv. 20', '{"Meat": 6400000, "Wood": 6400000, "Coal": 1200000, "Iron": 320000}', '9:52:30', 60452),
('Command Center', 21, 'Furnace Lv. 21, Embassy Lv. 21', '{"Meat": 8100000, "Wood": 8100000, "Coal": 1600000, "Iron": 400000}', '12:50:00', 68488),
('Command Center', 22, 'Furnace Lv. 22, Embassy Lv. 22', '{"Meat": 10000000, "Wood": 10000000, "Coal": 2100000, "Iron": 540000}', '19:15:30', 80542),
('Command Center', 23, 'Furnace Lv. 23, Embassy Lv. 23', '{"Meat": 13000000, "Wood": 13000000, "Coal": 2600000, "Iron": 670000}', '1d 02:57:00', 92596),
('Command Center', 24, 'Furnace Lv. 24, Embassy Lv. 24', '{"Meat": 18000000, "Wood": 18000000, "Coal": 3600000, "Iron": 900000}', '1d 13:44:00', 104650),
('Command Center', 25, 'Furnace Lv. 25, Embassy Lv. 25', '{"Meat": 24000000, "Wood": 24000000, "Coal": 4900000, "Iron": 1200000}', '2d 04:50:00', 116704),
('Command Center', 26, 'Furnace Lv. 26, Embassy Lv. 26', '{"Meat": 31000000, "Wood": 31000000, "Coal": 6300000, "Iron": 1500000}', '2d 12:46:00', 134414),
('Command Center', 27, 'Furnace Lv. 27, Embassy Lv. 27', '{"Meat": 44000000, "Wood": 44000000, "Coal": 8900000, "Iron": 2200000}', '3d 00:55:00', 152124),
('Command Center', 28, 'Furnace Lv. 28, Embassy Lv. 28', '{"Meat": 59000000, "Wood": 59000000, "Coal": 11000000, "Iron": 2900000}', '3d 11:51:00', 169834),
('Command Center', 29, 'Furnace Lv. 29, Embassy Lv. 29', '{"Meat": 73000000, "Wood": 73000000, "Coal": 18000000, "Iron": 4500000}', '4d 00:26:00', 187544),
('Command Center', 30, 'Furnace Lv. 30, Embassy Lv. 30', '{"Meat": 90000000, "Wood": 90000000, "Coal": 18000000, "Iron": 4500000}', '4d 19:44:00', 213290),
-- Embassy levels (first 15 levels)
('Embassy', 1, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 60, "Coal": 0, "Iron": 0}', '0:00:02', 440),
('Embassy', 2, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 90, "Coal": 0, "Iron": 0}', '0:00:10', 836),
('Embassy', 3, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 400, "Coal": 0, "Iron": 0}', '0:01:00', 1430),
('Embassy', 4, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 900, "Coal": 180, "Iron": 0}', '0:02:00', 2222),
('Embassy', 5, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 3800, "Coal": 760, "Iron": 0}', '0:06:40', 3410),
('Embassy', 6, 'Furnace Lv. 8', '{"Meat": 480, "Wood": 9600, "Coal": 1900, "Iron": 0}', '0:13:20', 5192),
('Embassy', 7, 'Furnace Lv. 8', '{"Meat": 1700, "Wood": 34000, "Coal": 6900, "Iron": 0}', '0:25:00', 7766),
('Embassy', 8, 'Furnace Lv. 8', '{"Meat": 3100, "Wood": 63000, "Coal": 12000, "Iron": 0}', '0:45:00', 10340),
('Embassy', 9, 'Furnace Lv. 9', '{"Meat": 6500, "Wood": 130000, "Coal": 26000, "Iron": 0}', '2:00:00', 12914),
('Embassy', 10, 'Furnace Lv. 10', '{"Meat": 11000, "Wood": 230000, "Coal": 46000, "Iron": 0}', '3:57:30', 16654),
('Embassy', 11, 'Furnace Lv. 11', '{"Meat": 13000, "Wood": 260000, "Coal": 260000, "Iron": 52000}', '4:57:00', 20394),
('Embassy', 12, 'Furnace Lv. 12', '{"Meat": 16000, "Wood": 330000, "Coal": 330000, "Iron": 67000}', '5:56:00', 24134),
('Embassy', 13, 'Furnace Lv. 13', '{"Meat": 23000, "Wood": 470000, "Coal": 470000, "Iron": 95000}', '7:15:30', 30448),
('Embassy', 14, 'Furnace Lv. 14', '{"Meat": 31000, "Wood": 630000, "Coal": 630000, "Iron": 120000}', '9:14:00', 36762),
('Embassy', 15, 'Furnace Lv. 15', '{"Meat": 46000, "Wood": 930000, "Coal": 930000, "Iron": 180000}', '11:52:30', 43076),
('Embassy', 16, 'Furnace Lv. 16', '{"Meat": 59000, "Wood": 1100000, "Coal": 1100000, "Iron": 230000}', '20:07:00', 51964),
('Embassy', 17, 'Furnace Lv. 17', '{"Meat": 93000, "Wood": 1800000, "Coal": 1800000, "Iron": 370000}', '1d 00:08:00', 60852),
('Embassy', 18, 'Furnace Lv. 18', '{"Meat": 120000, "Wood": 2500000, "Coal": 2500000, "Iron": 500000}', '1d 04:58:00', 69740),
('Embassy', 19, 'Furnace Lv. 19', '{"Meat": 150000, "Wood": 3100000, "Coal": 3100000, "Iron": 620000}', '1d 19:27:00', 82368),
('Embassy', 20, 'Furnace Lv. 20', '{"Meat": 210000, "Wood": 4300000, "Coal": 4300000, "Iron": 860000}', '2d 06:19:00', 94996),
('Embassy', 21, 'Furnace Lv. 21', '{"Meat": 270000, "Wood": 5400000, "Coal": 5400000, "Iron": 1000000}', '2d 22:36:00', 107624),
('Embassy', 22, 'Furnace Lv. 22', '{"Meat": 360000, "Wood": 7200000, "Coal": 7200000, "Iron": 1400000}', '4d 09:55:00', 126566),
('Embassy', 23, 'Furnace Lv. 23', '{"Meat": 440000, "Wood": 8900000, "Coal": 8900000, "Iron": 1700000}', '6d 04:17:00', 145508),
('Embassy', 24, 'Furnace Lv. 24', '{"Meat": 600000, "Wood": 12000000, "Coal": 12000000, "Iron": 2400000}', '8d 15:36:00', 164450),
('Embassy', 25, 'Furnace Lv. 25', '{"Meat": 810000, "Wood": 16000000, "Coal": 16000000, "Iron": 3200000}', '12d 02:38:00', 183392),
('Embassy', 26, 'Furnace Lv. 26', '{"Meat": 1000000, "Wood": 21000000, "Coal": 21000000, "Iron": 4200000}', '13d 22:14:00', 211222),
('Embassy', 27, 'Furnace Lv. 27', '{"Meat": 1400000, "Wood": 29000000, "Coal": 29000000, "Iron": 5900000}', '16d 17:05:00', 239052),
('Embassy', 28, 'Furnace Lv. 28', '{"Meat": 1900000, "Wood": 39000000, "Coal": 39000000, "Iron": 7900000}', '19d 05:15:00', 266882),
('Embassy', 29, 'Furnace Lv. 29', '{"Meat": 2400000, "Wood": 49000000, "Coal": 49000000, "Iron": 9800000}', '22d 02:26:00', 294712),
('Embassy', 30, 'Furnace Lv. 30', '{"Meat": 3000000, "Wood": 60000000, "Coal": 60000000, "Iron": 12000000}', '26d 12:32:00', 335170),
-- Furnace levels (all 30 levels)
('Furnace', 1, null, '{"Meat": 60, "Wood": 0, "Coal": 0, "Iron": 0}', '0:00:02', 440),
('Furnace', 2, null, '{"Meat": 90, "Wood": 0, "Coal": 0, "Iron": 0}', '0:00:10', 836),
('Furnace', 3, null, '{"Meat": 400, "Wood": 0, "Coal": 0, "Iron": 0}', '0:01:00', 1430),
('Furnace', 4, null, '{"Meat": 900, "Wood": 180, "Coal": 0, "Iron": 0}', '0:02:00', 2222),
('Furnace', 5, null, '{"Meat": 3800, "Wood": 760, "Coal": 0, "Iron": 0}', '0:06:40', 3410),
('Furnace', 6, null, '{"Meat": 9600, "Wood": 1900, "Coal": 480, "Iron": 0}', '0:13:20', 5192),
('Furnace', 7, null, '{"Meat": 34000, "Wood": 6900, "Coal": 1700, "Iron": 0}', '0:25:00', 7766),
('Furnace', 8, null, '{"Meat": 63000, "Wood": 12000, "Coal": 3100, "Iron": 0}', '0:45:00', 10340),
('Furnace', 9, 'Furnace Lv. 9', '{"Meat": 130000, "Wood": 26000, "Coal": 6500, "Iron": 0}', '2:00:00', 12914),
('Furnace', 10, 'Furnace Lv. 10', '{"Meat": 230000, "Wood": 46000, "Coal": 11000, "Iron": 0}', '3:57:30', 16654),
('Furnace', 11, 'Furnace Lv. 11', '{"Meat": 260000, "Wood": 260000, "Coal": 52000, "Iron": 13000}', '4:57:00', 20394),
('Furnace', 12, 'Furnace Lv. 12', '{"Meat": 330000, "Wood": 330000, "Coal": 67000, "Iron": 16000}', '5:56:00', 24134),
('Furnace', 13, 'Furnace Lv. 13', '{"Meat": 470000, "Wood": 470000, "Coal": 95000, "Iron": 23000}', '7:15:30', 30448),
('Furnace', 14, 'Furnace Lv. 14', '{"Meat": 630000, "Wood": 630000, "Coal": 120000, "Iron": 31000}', '9:14:00', 36762),
('Furnace', 15, 'Furnace Lv. 15', '{"Meat": 930000, "Wood": 930000, "Coal": 180000, "Iron": 46000}', '11:52:30', 43076),
('Furnace', 16, 'Furnace Lv. 16', '{"Meat": 1100000, "Wood": 1100000, "Coal": 230000, "Iron": 59000}', '20:07:00', 51964),
('Furnace', 17, 'Furnace Lv. 17', '{"Meat": 1800000, "Wood": 1800000, "Coal": 370000, "Iron": 93000}', '1d 00:08:00', 60852),
('Furnace', 18, 'Furnace Lv. 18', '{"Meat": 2500000, "Wood": 2500000, "Coal": 500000, "Iron": 120000}', '1d 04:58:00', 69740),
('Furnace', 19, 'Furnace Lv. 19', '{"Meat": 3100000, "Wood": 3100000, "Coal": 620000, "Iron": 150000}', '1d 19:27:00', 82368),
('Furnace', 20, 'Furnace Lv. 20', '{"Meat": 4300000, "Wood": 4300000, "Coal": 860000, "Iron": 210000}', '2d 06:19:00', 94996),
('Furnace', 21, 'Furnace Lv. 21', '{"Meat": 5400000, "Wood": 5400000, "Coal": 1000000, "Iron": 270000}', '2d 22:36:00', 107624),
('Furnace', 22, 'Furnace Lv. 22', '{"Meat": 7200000, "Wood": 7200000, "Coal": 1400000, "Iron": 360000}', '4d 09:55:00', 126566),
('Furnace', 23, 'Furnace Lv. 23', '{"Meat": 8900000, "Wood": 8900000, "Coal": 1700000, "Iron": 440000}', '6d 04:17:00', 145508),
('Furnace', 24, 'Furnace Lv. 24', '{"Meat": 12000000, "Wood": 12000000, "Coal": 2400000, "Iron": 600000}', '8d 15:36:00', 164450),
('Furnace', 25, 'Furnace Lv. 25', '{"Meat": 16000000, "Wood": 16000000, "Coal": 3200000, "Iron": 810000}', '12d 02:38:00', 183392),
('Furnace', 26, 'Furnace Lv. 26', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4200000, "Iron": 1000000}', '13d 22:14:00', 211222),
('Furnace', 27, 'Furnace Lv. 27', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000}', '16d 17:05:00', 239052),
('Furnace', 28, 'Furnace Lv. 28', '{"Meat": 39000000, "Wood": 39000000, "Coal": 7900000, "Iron": 1900000}', '19d 05:15:00', 266882),
('Furnace', 29, 'Furnace Lv. 29', '{"Meat": 49000000, "Wood": 49000000, "Coal": 9800000, "Iron": 2400000}', '22d 02:26:00', 294712),
('Furnace', 30, 'Furnace Lv. 30', '{"Meat": 60000000, "Wood": 60000000, "Coal": 12000000, "Iron": 3000000}', '26d 12:32:00', 335170)
ON CONFLICT DO NOTHING;

-- Add Iron Mine levels (all 30 levels)
INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) VALUES
('Iron Mine', 1, 'Furnace Lv. 5', '{"Meat": 0, "Wood": 30, "Coal": 0, "Iron": 0}', '0:00:02', 40),
('Iron Mine', 2, 'Furnace Lv. 5', '{"Meat": 0, "Wood": 45, "Coal": 0, "Iron": 0}', '0:00:03', 76),
('Iron Mine', 3, 'Furnace Lv. 5', '{"Meat": 0, "Wood": 200, "Coal": 0, "Iron": 0}', '0:00:10', 130),
('Iron Mine', 4, 'Furnace Lv. 5', '{"Meat": 0, "Wood": 450, "Coal": 90, "Iron": 0}', '0:00:35', 202),
('Iron Mine', 5, 'Furnace Lv. 5', '{"Meat": 0, "Wood": 1900, "Coal": 380, "Iron": 0}', '0:01:10', 310),
('Iron Mine', 6, 'Furnace Lv. 6', '{"Meat": 240, "Wood": 4800, "Coal": 960, "Iron": 0}', '0:02:20', 472),
('Iron Mine', 7, 'Furnace Lv. 7', '{"Meat": 865, "Wood": 17000, "Coal": 3400, "Iron": 0}', '0:04:45', 706),
('Iron Mine', 8, 'Furnace Lv. 8', '{"Meat": 1500, "Wood": 31000, "Coal": 6300, "Iron": 0}', '0:07:10', 940),
('Iron Mine', 9, 'Furnace Lv. 9', '{"Meat": 3200, "Wood": 65000, "Coal": 13000, "Iron": 0}', '0:10:30', 1174),
('Iron Mine', 10, 'Furnace Lv. 10', '{"Meat": 5700, "Wood": 110000, "Coal": 23000, "Iron": 0}', '0:14:00', 1514),
('Iron Mine', 11, 'Furnace Lv. 11', '{"Meat": 5900, "Wood": 110000, "Coal": 110000, "Iron": 23000}', '0:18:00', 1854),
('Iron Mine', 12, 'Furnace Lv. 12', '{"Meat": 7500, "Wood": 150000, "Coal": 150000, "Iron": 30000}', '0:21:30', 2194),
('Iron Mine', 13, 'Furnace Lv. 13', '{"Meat": 10000, "Wood": 210000, "Coal": 210000, "Iron": 42000}', '0:26:00', 2768),
('Iron Mine', 14, 'Furnace Lv. 14', '{"Meat": 14000, "Wood": 280000, "Coal": 280000, "Iron": 56000}', '0:33:30', 3342),
('Iron Mine', 15, 'Furnace Lv. 15', '{"Meat": 20000, "Wood": 410000, "Coal": 410000, "Iron": 83000}', '0:43:00', 3916),
('Iron Mine', 16, 'Furnace Lv. 16', '{"Meat": 26000, "Wood": 530000, "Coal": 530000, "Iron": 100000}', '1:13:00', 4724),
('Iron Mine', 17, 'Furnace Lv. 17', '{"Meat": 41000, "Wood": 830000, "Coal": 830000, "Iron": 160000}', '1:27:30', 5532),
('Iron Mine', 18, 'Furnace Lv. 18', '{"Meat": 56000, "Wood": 1100000, "Coal": 1100000, "Iron": 220000}', '1:45:00', 6340),
('Iron Mine', 19, 'Furnace Lv. 19', '{"Meat": 70000, "Wood": 1400000, "Coal": 1400000, "Iron": 280000}', '2:38:00', 7488),
('Iron Mine', 20, 'Furnace Lv. 20', '{"Meat": 96000, "Wood": 1900000, "Coal": 1900000, "Iron": 300000}', '3:17:30', 8636),
('Iron Mine', 21, 'Furnace Lv. 21', '{"Meat": 120000, "Wood": 2400000, "Coal": 2400000, "Iron": 490000}', '4:16:30', 9784),
('Iron Mine', 22, 'Furnace Lv. 22', '{"Meat": 160000, "Wood": 3200000, "Coal": 3200000, "Iron": 640000}', '6:25:00', 11506),
('Iron Mine', 23, 'Furnace Lv. 23', '{"Meat": 200000, "Wood": 4000000, "Coal": 4000000, "Iron": 800000}', '8:59:00', 13228),
('Iron Mine', 24, 'Furnace Lv. 24', '{"Meat": 270000, "Wood": 5400000, "Coal": 5400000, "Iron": 1000000}', '12:34:30', 14950),
('Iron Mine', 25, 'Furnace Lv. 25', '{"Meat": 360000, "Wood": 7300000, "Coal": 7300000, "Iron": 1400000}', '17:36:30', 16672),
('Iron Mine', 26, 'Furnace Lv. 26', '{"Meat": 470000, "Wood": 9400000, "Coal": 9400000, "Iron": 1800000}', '20:15:00', 19202),
('Iron Mine', 27, 'Furnace Lv. 27', '{"Meat": 670000, "Wood": 13000000, "Coal": 13000000, "Iron": 2600000}', '1d 00:18:00', 21732),
('Iron Mine', 28, 'Furnace Lv. 28', '{"Meat": 890000, "Wood": 17000000, "Coal": 17000000, "Iron": 3500000}', '1d 03:57:00', 24262),
('Iron Mine', 29, 'Furnace Lv. 29', '{"Meat": 1100000, "Wood": 22000000, "Coal": 22000000, "Iron": 4400000}', '1d 08:08:00', 26792),
('Iron Mine', 30, 'Furnace Lv. 30', '{"Meat": 1300000, "Wood": 27000000, "Coal": 27000000, "Iron": 5400000}', '1d 14:34:00', 30470)
ON CONFLICT DO NOTHING;

-- Add Infirmary levels (all 30 levels)
INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) VALUES
('Infirmary', 1, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 0, "Coal": 0, "Iron": 0}', '0:00:02', 300),
('Infirmary', 2, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 100, "Coal": 0, "Iron": 0}', '0:00:09', 570),
('Infirmary', 3, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 460, "Coal": 0, "Iron": 0}', '0:00:40', 975),
('Infirmary', 4, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 1000, "Coal": 205, "Iron": 0}', '0:02:05', 1515),
('Infirmary', 5, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 4300, "Coal": 865, "Iron": 0}', '0:04:10', 2325),
('Infirmary', 6, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 10000, "Coal": 2100, "Iron": 545}', '0:08:20', 3540),
('Infirmary', 7, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 39000, "Coal": 7800, "Iron": 1900}', '0:16:30', 5295),
('Infirmary', 8, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 72000, "Coal": 14000, "Iron": 3600}', '0:25:00', 7050),
('Infirmary', 9, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 140000, "Coal": 29000, "Iron": 7400}', '0:27:30', 8805),
('Infirmary', 10, 'Furnace Lv. 10', '{"Meat": 0, "Wood": 260000, "Coal": 52000, "Iron": 13000}', '0:50:00', 11355),
('Infirmary', 11, 'Furnace Lv. 11', '{"Meat": 320000, "Wood": 320000, "Coal": 65000, "Iron": 16000}', '1:03:00', 13905),
('Infirmary', 12, 'Furnace Lv. 12', '{"Meat": 420000, "Wood": 420000, "Coal": 54000, "Iron": 21000}', '1:15:30', 16455),
('Infirmary', 13, 'Furnace Lv. 13', '{"Meat": 590000, "Wood": 590000, "Coal": 110000, "Iron": 29000}', '1:32:00', 20760),
('Infirmary', 14, 'Furnace Lv. 14', '{"Meat": 780000, "Wood": 780000, "Coal": 150000, "Iron": 39000}', '1:57:30', 25065),
('Infirmary', 15, 'Furnace Lv. 15', '{"Meat": 1100000, "Wood": 1100000, "Coal": 230000, "Iron": 58000}', '2:31:00', 29370),
('Infirmary', 16, 'Furnace Lv. 16', '{"Meat": 1400000, "Wood": 1400000, "Coal": 290000, "Iron": 74000}', '4:16:00', 35430),
('Infirmary', 17, 'Furnace Lv. 17', '{"Meat": 2300000, "Wood": 2300000, "Coal": 460000, "Iron": 110000}', '5:07:00', 41490),
('Infirmary', 18, 'Furnace Lv. 18', '{"Meat": 3100000, "Wood": 3100000, "Coal": 620000, "Iron": 150000}', '6:08:30', 47550),
('Infirmary', 19, 'Furnace Lv. 19', '{"Meat": 3900000, "Wood": 3900000, "Coal": 780000, "Iron": 190000}', '9:13:00', 56160),
('Infirmary', 20, 'Furnace Lv. 20', '{"Meat": 5300000, "Wood": 5300000, "Coal": 1000000, "Iron": 260000}', '11:31:00', 64770),
('Infirmary', 21, 'Furnace Lv. 21', '{"Meat": 6800000, "Wood": 6800000, "Coal": 1300000, "Iron": 340000}', '14:58:30', 73380),
('Infirmary', 22, 'Furnace Lv. 22', '{"Meat": 9000000, "Wood": 9000000, "Coal": 1800000, "Iron": 450000}', '22:28:00', 86295),
('Infirmary', 23, 'Furnace Lv. 23', '{"Meat": 11000000, "Wood": 11000000, "Coal": 2200000, "Iron": 560000}', '1d 07:27:00', 99210),
('Infirmary', 24, 'Furnace Lv. 24', '{"Meat": 15000000, "Wood": 15000000, "Coal": 3000000, "Iron": 750000}', '1d 20:02:00', 112125),
('Infirmary', 25, 'Furnace Lv. 25', '{"Meat": 20000000, "Wood": 20000000, "Coal": 4000000, "Iron": 1000000}', '2d 13:39:00', 125040),
('Infirmary', 26, 'Furnace Lv. 26', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5200000, "Iron": 1300000}', '2d 22:54:00', 144015),
('Infirmary', 27, 'Furnace Lv. 27', '{"Meat": 37000000, "Wood": 37000000, "Coal": 7400000, "Iron": 1800000}', '3d 13:04:00', 162990),
('Infirmary', 28, 'Furnace Lv. 28', '{"Meat": 49000000, "Wood": 49000000, "Coal": 9900000, "Iron": 2400000}', '4d 01:50:00', 181965),
('Infirmary', 29, 'Furnace Lv. 29', '{"Meat": 61000000, "Wood": 61000000, "Coal": 12000000, "Iron": 3000000}', '4d 16:31:00', 200940),
('Infirmary', 30, 'Furnace Lv. 30', '{"Meat": 75000000, "Wood": 75000000, "Coal": 15000000, "Iron": 3700000}', '5d 15:01:00', 228525),

-- Marksman Camp building levels
('Marksman Camp', 1, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 95, "Coal": 0, "Iron": 0}', '0:00:02', 400),
('Marksman Camp', 2, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 140, "Coal": 0, "Iron": 0}', '0:00:09', 760),
('Marksman Camp', 3, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 645, "Coal": 0, "Iron": 0}', '0:00:45', 1300),
('Marksman Camp', 4, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 1400, "Coal": 285, "Iron": 0}', '0:02:15', 2020),
('Marksman Camp', 5, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 6000, "Coal": 1200, "Iron": 0}', '0:04:30', 3100),
('Marksman Camp', 6, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 15000, "Coal": 3000, "Iron": 765}', '0:09:00', 4720),
('Marksman Camp', 7, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 55000, "Coal": 11000, "Iron": 2700}', '0:18:00', 7060),
('Marksman Camp', 8, 'Furnace Lv. 8', '{"Meat": 0, "Wood": 100000, "Coal": 20000, "Iron": 5000}', '0:27:00', 9400),
('Marksman Camp', 9, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 200000, "Coal": 41000, "Iron": 10000}', '0:40:30', 11740),
('Marksman Camp', 10, 'Furnace Lv. 10', '{"Meat": 0, "Wood": 360000, "Coal": 73000, "Iron": 18000}', '0:54:00', 15140),
('Marksman Camp', 11, 'Furnace Lv. 11', '{"Meat": 460000, "Wood": 460000, "Coal": 92000, "Iron": 23000}', '1:07:30', 18540),
('Marksman Camp', 12, 'Furnace Lv. 12', '{"Meat": 580000, "Wood": 580000, "Coal": 110000, "Iron": 29000}', '1:21:00', 21940),
('Marksman Camp', 13, 'Furnace Lv. 13', '{"Meat": 830000, "Wood": 830000, "Coal": 160000, "Iron": 41000}', '1:39:00', 27680),
('Marksman Camp', 14, 'Furnace Lv. 14', '{"Meat": 1100000, "Wood": 1100000, "Coal": 220000, "Iron": 55000}', '2:06:00', 33420),
('Marksman Camp', 15, 'Furnace Lv. 15', '{"Meat": 1600000, "Wood": 1600000, "Coal": 320000, "Iron": 81000}', '2:42:00', 39160),
('Marksman Camp', 16, 'Furnace Lv. 16', '{"Meat": 2000000, "Wood": 2000000, "Coal": 410000, "Iron": 100000}', '4:34:00', 47240),
('Marksman Camp', 17, 'Furnace Lv. 17', '{"Meat": 3200000, "Wood": 3200000, "Coal": 650000, "Iron": 160000}', '5:29:00', 55320),
('Marksman Camp', 18, 'Furnace Lv. 18', '{"Meat": 4300000, "Wood": 4300000, "Coal": 870000, "Iron": 210000}', '6:35:00', 63400),
('Marksman Camp', 19, 'Furnace Lv. 19', '{"Meat": 5400000, "Wood": 5400000, "Coal": 1000000, "Iron": 270000}', '9:52:30', 74880),
('Marksman Camp', 20, 'Furnace Lv. 20', '{"Meat": 7500000, "Wood": 7500000, "Coal": 1500000, "Iron": 370000}', '12:20:30', 86360),
('Marksman Camp', 21, 'Furnace Lv. 21', '{"Meat": 9500000, "Wood": 9500000, "Coal": 1900000, "Iron": 470000}', '16:02:30', 97840),
('Marksman Camp', 22, 'Furnace Lv. 22', '{"Meat": 12000000, "Wood": 12000000, "Coal": 2500000, "Iron": 630000}', '1d 00:04:00', 115060),
('Marksman Camp', 23, 'Furnace Lv. 23', '{"Meat": 15000000, "Wood": 15000000, "Coal": 3100000, "Iron": 490000}', '1d 09:42:00', 132280),
('Marksman Camp', 24, 'Furnace Lv. 24', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4200000, "Iron": 1000000}', '1d 23:11:00', 149500),
('Marksman Camp', 25, 'Furnace Lv. 25', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000}', '2d 18:03:00', 166720),
('Marksman Camp', 26, 'Furnace Lv. 26', '{"Meat": 36000000, "Wood": 36000000, "Coal": 7300000, "Iron": 1800000}', '3d 03:57:00', 192020),
('Marksman Camp', 27, 'Furnace Lv. 27', '{"Meat": 52000000, "Wood": 52000000, "Coal": 10000000, "Iron": 2600000}', '3d 19:09:00', 217320),
('Marksman Camp', 28, 'Furnace Lv. 28', '{"Meat": 69000000, "Wood": 69000000, "Coal": 13000000, "Iron": 3400000}', '4d 08:49:00', 242620),
('Marksman Camp', 29, 'Furnace Lv. 29', '{"Meat": 86000000, "Wood": 86000000, "Coal": 17000000, "Iron": 4300000}', '5d 00:33:00', 267920),
('Marksman Camp', 30, 'Furnace Lv. 30', '{"Meat": 100000000, "Wood": 100000000, "Coal": 21000000, "Iron": 5200000}', '6d 00:40:00', 304700),

-- Storehouse building levels
('Storehouse', 1, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 60, "Coal": 0, "Iron": 0}', '0:00:02', 440),
('Storehouse', 2, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 90, "Coal": 0, "Iron": 0}', '0:00:09', 836),
('Storehouse', 3, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 400, "Coal": 0, "Iron": 0}', '0:00:45', 1430),
('Storehouse', 4, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 900, "Coal": 180, "Iron": 0}', '0:02:15', 2222),
('Storehouse', 5, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 3800, "Coal": 760, "Iron": 0}', '0:04:30', 3410),
('Storehouse', 6, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 9600, "Coal": 1900, "Iron": 480}', '0:09:00', 5192),
('Storehouse', 7, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 34000, "Coal": 6900, "Iron": 1700}', '0:18:00', 7766),
('Storehouse', 8, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 63000, "Coal": 12000, "Iron": 3100}', '0:27:00', 10340),
('Storehouse', 9, 'Furnace Lv. 9', '{"Meat": 0, "Wood": 130000, "Coal": 26000, "Iron": 6500}', '0:40:30', 12914),
('Storehouse', 10, 'Furnace Lv. 10', '{"Meat": 0, "Wood": 230000, "Coal": 46000, "Iron": 11000}', '0:54:00', 16654),
('Storehouse', 11, 'Furnace Lv. 11', '{"Meat": 280000, "Wood": 280000, "Coal": 57000, "Iron": 14000}', '1:07:30', 20394),
('Storehouse', 12, 'Furnace Lv. 12', '{"Meat": 370000, "Wood": 370000, "Coal": 74000, "Iron": 18000}', '1:21:00', 24134),
('Storehouse', 13, 'Furnace Lv. 13', '{"Meat": 520000, "Wood": 520000, "Coal": 100000, "Iron": 26000}', '1:39:00', 30448),
('Storehouse', 14, 'Furnace Lv. 14', '{"Meat": 690000, "Wood": 690000, "Coal": 130000, "Iron": 34000}', '2:06:00', 36762),
('Storehouse', 15, 'Furnace Lv. 15', '{"Meat": 1000000, "Wood": 1000000, "Coal": 200000, "Iron": 51000}', '2:42:00', 43076),
('Storehouse', 16, 'Furnace Lv. 16', '{"Meat": 1300000, "Wood": 1300000, "Coal": 260000, "Iron": 65000}', '4:34:00', 51964),
('Storehouse', 17, 'Furnace Lv. 17', '{"Meat": 2000000, "Wood": 2000000, "Coal": 400000, "Iron": 100000}', '5:29:00', 60852),
('Storehouse', 18, 'Furnace Lv. 18', '{"Meat": 2700000, "Wood": 2700000, "Coal": 550000, "Iron": 130000}', '6:35:00', 69740),
('Storehouse', 19, 'Furnace Lv. 19', '{"Meat": 3400000, "Wood": 3400000, "Coal": 690000, "Iron": 170000}', '9:52:30', 82368),
('Storehouse', 20, 'Furnace Lv. 20', '{"Meat": 4700000, "Wood": 4700000, "Coal": 940000, "Iron": 230000}', '12:20:30', 94996),
('Storehouse', 21, 'Furnace Lv. 21', '{"Meat": 6000000, "Wood": 6000000, "Coal": 1200000, "Iron": 300000}', '16:02:30', 107624),
('Storehouse', 22, 'Furnace Lv. 22', '{"Meat": 7900000, "Wood": 7900000, "Coal": 1500000, "Iron": 390000}', '1d 00:04:00', 126566),
('Storehouse', 23, 'Furnace Lv. 23', '{"Meat": 9800000, "Wood": 9800000, "Coal": 1900000, "Iron": 490000}', '1d 09:42:00', 145508),
('Storehouse', 24, 'Furnace Lv. 24', '{"Meat": 13000000, "Wood": 13000000, "Coal": 2600000, "Iron": 660000}', '1d 23:11:00', 164450),
('Storehouse', 25, 'Furnace Lv. 25', '{"Meat": 17000000, "Wood": 17000000, "Coal": 3500000, "Iron": 890000}', '2d 18:03:00', 183392),
('Storehouse', 26, 'Furnace Lv. 26', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4600000, "Iron": 1100000}', '3d 03:57:00', 211222),
('Storehouse', 27, 'Furnace Lv. 27', '{"Meat": 32000000, "Wood": 32000000, "Coal": 6500000, "Iron": 1600000}', '3d 19:09:00', 239052),
('Storehouse', 28, 'Furnace Lv. 28', '{"Meat": 43000000, "Wood": 43000000, "Coal": 8700000, "Iron": 2100000}', '4d 08:49:00', 266882),
('Storehouse', 29, 'Furnace Lv. 29', '{"Meat": 54000000, "Wood": 54000000, "Coal": 10000000, "Iron": 2700000}', '5d 00:33:00', 294712),
('Storehouse', 30, 'Furnace Lv. 30', '{"Meat": 66000000, "Wood": 66000000, "Coal": 13000000, "Iron": 3300000}', '6d 00:40:00', 335170)
ON CONFLICT DO NOTHING;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_game_states_player_id ON game_states(player_id);
CREATE INDEX IF NOT EXISTS idx_game_states_updated_at ON game_states(updated_at);
CREATE INDEX IF NOT EXISTS idx_strategies_player_id ON strategies(player_id);
CREATE INDEX IF NOT EXISTS idx_strategies_category ON strategies(category);
CREATE INDEX IF NOT EXISTS idx_strategies_created_at ON strategies(created_at);
CREATE INDEX IF NOT EXISTS idx_heroes_role ON heroes(role);
CREATE INDEX IF NOT EXISTS idx_heroes_rarity ON heroes(rarity);
CREATE INDEX IF NOT EXISTS idx_heroes_generation ON heroes(generation);
CREATE INDEX IF NOT EXISTS idx_hero_upgrade_costs_star_tier ON hero_upgrade_costs(star_level, tier_level);
CREATE INDEX IF NOT EXISTS idx_building_levels_building_name ON building_levels(building_name);
CREATE INDEX IF NOT EXISTS idx_building_levels_level ON building_levels(level);
CREATE INDEX IF NOT EXISTS idx_building_levels_building_power ON building_levels(building_power);

-- Enable Row Level Security (RLS)
ALTER TABLE players ENABLE ROW LEVEL SECURITY;
ALTER TABLE game_states ENABLE ROW LEVEL SECURITY;
ALTER TABLE strategies ENABLE ROW LEVEL SECURITY;
ALTER TABLE heroes ENABLE ROW LEVEL SECURITY;
ALTER TABLE hero_upgrade_costs ENABLE ROW LEVEL SECURITY;
ALTER TABLE buildings ENABLE ROW LEVEL SECURITY;
ALTER TABLE building_levels ENABLE ROW LEVEL SECURITY;
ALTER TABLE resources ENABLE ROW LEVEL SECURITY;

-- Create RLS policies (basic policies - adjust based on your auth requirements)
-- Drop existing policies if they exist to avoid conflicts
DROP POLICY IF EXISTS "Users can view their own data" ON players;
DROP POLICY IF EXISTS "Users can manage their own game states" ON game_states;
DROP POLICY IF EXISTS "Users can manage their own strategies" ON strategies;
DROP POLICY IF EXISTS "Public read access to buildings" ON buildings;
DROP POLICY IF EXISTS "Public read access to building levels" ON building_levels;
DROP POLICY IF EXISTS "Public read access to resources" ON resources;
DROP POLICY IF EXISTS "Public read access to heroes" ON heroes;
DROP POLICY IF EXISTS "Public read access to hero upgrade costs" ON hero_upgrade_costs;

-- Create new policies
CREATE POLICY "Users can view their own data" ON players
  FOR ALL USING (auth.uid()::text = id::text);

CREATE POLICY "Users can manage their own game states" ON game_states
  FOR ALL USING (auth.uid()::text = player_id::text);

CREATE POLICY "Users can manage their own strategies" ON strategies
  FOR ALL USING (auth.uid()::text = player_id::text);

-- Allow public read access to reference tables
CREATE POLICY "Public read access to buildings" ON buildings
  FOR SELECT USING (true);

CREATE POLICY "Public read access to building levels" ON building_levels
  FOR SELECT USING (true);

CREATE POLICY "Public read access to resources" ON resources
  FOR SELECT USING (true);

CREATE POLICY "Public read access to heroes" ON heroes
  FOR SELECT USING (true);

CREATE POLICY "Public read access to hero upgrade costs" ON hero_upgrade_costs
  FOR SELECT USING (true);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
-- Drop existing triggers if they exist to avoid conflicts
DROP TRIGGER IF EXISTS update_players_updated_at ON players;
DROP TRIGGER IF EXISTS update_game_states_updated_at ON game_states;
DROP TRIGGER IF EXISTS update_strategies_updated_at ON strategies;

-- Create new triggers
CREATE TRIGGER update_players_updated_at BEFORE UPDATE ON players
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_game_states_updated_at BEFORE UPDATE ON game_states
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_strategies_updated_at BEFORE UPDATE ON strategies
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Grant necessary permissions
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;