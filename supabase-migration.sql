-- ============================================
-- Job Tracker — Supabase Migration
-- Exécuter dans le SQL Editor du dashboard Supabase
-- ============================================

-- TABLE: candidatures
CREATE TABLE IF NOT EXISTS candidatures (
  id TEXT PRIMARY KEY,
  entreprise TEXT NOT NULL,
  poste TEXT NOT NULL DEFAULT '',
  contact TEXT DEFAULT '',
  source TEXT DEFAULT '',
  date DATE,
  statut TEXT DEFAULT 'envoyee',
  relance_date DATE,
  lieu TEXT DEFAULT '',
  url TEXT DEFAULT '',
  salaire TEXT DEFAULT '',
  notes TEXT DEFAULT '',
  history JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- TABLE: esn (réseau pro)
CREATE TABLE IF NOT EXISTS esn (
  id TEXT PRIMARY KEY,
  nom TEXT NOT NULL,
  type TEXT DEFAULT 'esn',
  priorite TEXT DEFAULT 'new',
  site TEXT DEFAULT '',
  carrieres TEXT DEFAULT '',
  ville TEXT DEFAULT '',
  specialites TEXT DEFAULT '',
  linkedin TEXT DEFAULT '',
  contacts JSONB DEFAULT '[]'::jsonb,
  contact_ref_ids TEXT[] DEFAULT '{}',
  notes TEXT DEFAULT '',
  candidature_ids TEXT[] DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- TABLE: contacts_rh
CREATE TABLE IF NOT EXISTS contacts_rh (
  id TEXT PRIMARY KEY,
  nom TEXT NOT NULL,
  role TEXT DEFAULT '',
  entreprise TEXT NOT NULL DEFAULT '',
  ville TEXT DEFAULT '',
  email TEXT DEFAULT '',
  telephone TEXT DEFAULT '',
  linkedin TEXT DEFAULT '',
  statut TEXT DEFAULT 'a-contacter',
  priorite TEXT DEFAULT 'normal',
  source TEXT DEFAULT '',
  notes TEXT DEFAULT '',
  objectifs JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- RLS: Activer Row Level Security
ALTER TABLE candidatures ENABLE ROW LEVEL SECURITY;
ALTER TABLE esn ENABLE ROW LEVEL SECURITY;
ALTER TABLE contacts_rh ENABLE ROW LEVEL SECURITY;

-- Policies: accès public en lecture/écriture (app perso, pas d'auth)
CREATE POLICY "Public read candidatures" ON candidatures FOR SELECT USING (true);
CREATE POLICY "Public insert candidatures" ON candidatures FOR INSERT WITH CHECK (true);
CREATE POLICY "Public update candidatures" ON candidatures FOR UPDATE USING (true);
CREATE POLICY "Public delete candidatures" ON candidatures FOR DELETE USING (true);

CREATE POLICY "Public read esn" ON esn FOR SELECT USING (true);
CREATE POLICY "Public insert esn" ON esn FOR INSERT WITH CHECK (true);
CREATE POLICY "Public update esn" ON esn FOR UPDATE USING (true);
CREATE POLICY "Public delete esn" ON esn FOR DELETE USING (true);

CREATE POLICY "Public read contacts_rh" ON contacts_rh FOR SELECT USING (true);
CREATE POLICY "Public insert contacts_rh" ON contacts_rh FOR INSERT WITH CHECK (true);
CREATE POLICY "Public update contacts_rh" ON contacts_rh FOR UPDATE USING (true);
CREATE POLICY "Public delete contacts_rh" ON contacts_rh FOR DELETE USING (true);
