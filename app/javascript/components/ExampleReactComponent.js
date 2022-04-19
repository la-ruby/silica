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

const onFileAction = (data) => {
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
    case ChonkyActions.UploadFiles.id:
      console.log(data.state.instanceId)
      window.location.href = '/projects/' + data.state.instanceId + '/project_files/new'
      break;
    default:
      console.log("here4")
      break;
  }
}


class ExampleReactComponent extends React.Component {

  render() {
    return (
      <FileBrowser
        instanceId={this.props.silicaProjectId}
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
