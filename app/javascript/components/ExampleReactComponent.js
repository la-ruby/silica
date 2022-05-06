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

// github.com/TimboKZ/Chonky/issues/34#issuecomment-705207987
ChonkyActions.ToggleShowFoldersFirst.option.defaultValue = false;

const onFileAction = (data) => {

  switch (data.id) {
    case ChonkyActions.OpenFiles.id:
      if (data.payload.files[0].isDir == undefined) {
        window.location.href = '/project_files/' + data.payload.files[0].id
      } else if (data.payload.files[0].isDir == true) {
        console.log(data.payload.targetFile.name)
	window.location.href = '/projects/' + data.state.instanceId + '?tab=files&folder=' + window.silica_chonky_current_folder + data.payload.targetFile.name + '/'
      } else {
	alert('(Error - 501: Not Implemented')
      }
      break;
    case ChonkyActions.CreateFolder.id:
      console.log("tracing 1651877138")
      break;
    case ChonkyActions.UploadFiles.id:
      // console.log(data.state.instanceId)
      window.location.href = '/projects/' + data.state.instanceId + '/project_files/new?folder=' + window.silica_chonky_current_folder
      break;
    default:
      console.log("trace1651042288")
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
        folderChain={[{ id: 'foo', name: 'baa', isDir: true }]}
	fileActions={[ChonkyActions.UploadFiles]}
        disableSelection={true}
        disableDragAndDrop={true}
        disableDefaultFileActions={[ChonkyActions.SelectAllFiles.id, ChonkyActions.OpenSelection.id, ChonkyActions.ClearSelection.id]}
      >
            <FileToolbar />
            <FileList />
            <FileContextMenu />
        </FileBrowser>
    );
  }
}

export default ExampleReactComponent
