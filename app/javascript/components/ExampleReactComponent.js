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
       } from 'chonky';


// https://chonky.io/docs/2.x/basics/icons
import { setChonkyDefaults } from 'chonky';
import { ChonkyIconFA } from 'chonky-icon-fontawesome';
setChonkyDefaults({ iconComponent: ChonkyIconFA });

class ExampleReactComponent extends React.Component {


  render() {
    const files = [
      { id: 'lht', name: 'older', isDir: true },
      {
        id: 'mcd',
        name: 'chonky-sphere-v2.png',
        thumbnailUrl: 'https://chonky.io/chonky-sphere-v2.png',
      },
    ]
    const folderChain = [{ id: 'xcv', name: 'Demo', isDir: true }]

    return (
      <div className="experiment1650288360">
	<FullFileBrowser
	  files={files}
	  folderChain={[]}
          disableDefaultFileActions={true}
          fileActions={[]}
	>
                <FileNavbar />
                <FileToolbar />
                <FileList />
                <FileContextMenu />
        </FullFileBrowser>


      </div>
    );
  }
}

export default ExampleReactComponent
