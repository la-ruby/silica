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
    { id: 'silica-folder-construction-remodel', name: 'Construction_Remodel', isDir: true } ]

  STANDARD_CONSTRUCTION_SUBFOLDERS = [
    { id: 'silica-folder-construction-pre', name: 'Pre', isDir: true },
    { id: 'silica-folder-construction-progress', name: 'Progress', isDir: true },
    { id: 'silica-folder-closing-construction-post', name: 'Post', isDir: true },
  ]

  # TEST_MOCKS = [ { id: 999999, name: 'exampleFile.png' } ].concat(STANDARD_FOLDERS)
end
