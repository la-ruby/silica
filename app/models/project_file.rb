# frozen_string_literal: true

class ProjectFile < ApplicationRecord
  belongs_to :project

  has_one_attached :silicafile

  TEST_MOCKS = [
    { id: 'lht', name: 'exampleFolder', isDir: true },
    {
      id: 999999,
      name: 'exampleFile.png'
    },
  ]
end
