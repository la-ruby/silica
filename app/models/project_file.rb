# frozen_string_literal: true

class ProjectFile < ApplicationRecord
  belongs_to :project

  has_one_attached :silicafile

  STANDARD_FOLDERS = [
    { id: 'silica-folder-underwriting', name: 'Underwriting', isDir: true },
    { id: 'silica-folder-contracts', name: 'Contracts', isDir: true },
    { id: 'silica-folder-closing-docs', name: 'Closing Docs', isDir: true },
    { id: 'silica-folder-insurance', name: 'Insurance', isDir: true },
    { id: 'silica-folder-utilities', name: 'Utilities', isDir: true },
    { id: 'silica-folder-construction-remodel', name: 'Construction/Remodel', isDir: true } ]

  # TEST_MOCKS = [ { id: 999999, name: 'exampleFile.png' } ].concat(STANDARD_FOLDERS)
end
