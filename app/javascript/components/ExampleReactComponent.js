import React from 'react';
import { FullFileBrowser,
    FileArray,
    FileBrowser,
    FileContextMenu,
    FileData,
    FileHelper,
    FileList,
    FileNavbar,
    FileToolbar,
    ChonkyActions } from 'chonky';


// https://chonky.io/docs/2.x/basics/icons
import { setChonkyDefaults } from 'chonky';
import { ChonkyIconFA } from 'chonky-icon-fontawesome';
setChonkyDefaults({ iconComponent: ChonkyIconFA });

class ExampleReactComponent extends React.Component {


  render() {
    const files = [
      { id: 'lht', name: 'archived', isDir: true },
      {
        id: 'mcd',
        name: 'chonky-sphere-v2.png',
        thumbnailUrl: 'https://chonky.io/chonky-sphere-v2.png',
      },
    ]
    const folderChain = [{ id: 'xcv', name: 'Demo', isDir: true }]

    return (
      <FileBrowser
	files={files}
	fileActions={[ChonkyActions.UploadFiles]}
        disableSelection={true}
        disableDragAndDrop={true}
        disableDefaultFileActions={[ChonkyActions.SelectAllFiles.id, ChonkyActions.OpenSelection.id, ChonkyActions.ClearSelection.id, ChonkyActions.SelectAllFiles.id]}
      > 
            <FileToolbar />
            <FileList />
            <FileContextMenu />
        </FileBrowser>
    );
  }
}

export default ExampleReactComponent
