-- Simplified schema without FTS5 for sql.js compatibility
CREATE TABLE IF NOT EXISTS nodes (
  node_type TEXT PRIMARY KEY,
  package_name TEXT NOT NULL,
  display_name TEXT NOT NULL,
  description TEXT,
  category TEXT,
  development_style TEXT CHECK(development_style IN ('declarative', 'programmatic')),
  is_ai_tool INTEGER DEFAULT 0,
  is_trigger INTEGER DEFAULT 0,
  is_webhook INTEGER DEFAULT 0,
  is_versioned INTEGER DEFAULT 0,
  version TEXT,
  documentation TEXT,
  properties_schema TEXT,
  operations TEXT,
  credentials_required TEXT,
  node_source_code TEXT,
  credential_source_code TEXT,
  source_location TEXT,
  source_extracted_at DATETIME,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_package ON nodes(package_name);
CREATE INDEX IF NOT EXISTS idx_ai_tool ON nodes(is_ai_tool);
CREATE INDEX IF NOT EXISTS idx_category ON nodes(category);
CREATE INDEX IF NOT EXISTS idx_display_name ON nodes(display_name);
CREATE INDEX IF NOT EXISTS idx_node_type ON nodes(node_type);

-- Templates table
CREATE TABLE IF NOT EXISTS templates (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT,
  content TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
