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

function onFileAction(data) {
  switch (data.id) {
    case ChonkyActions.OpenFiles.id:
      if (data.payload.files[0].isDir == undefined) {
        window.location.href = '/project_files/' + data.payload.files[0].id
      } else {
	alert('(Error - 501: Not Implemented')
      }
      break;
    case ChonkyActions.CreateFolder.id:
      console.log("here2")
      break;
    case ChonkyActions.DeleteFiles.id:
      console.log("here3")
      break;
    default:
      break;
  }
}


class ExampleReactComponent extends React.Component {

  render() {
    return (
      <FileBrowser
        fillParentContainer={true}
        onFileAction={onFileAction}
	files={this.props.files}
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
