import MyFileBrowser from './components/MyFileBrowser'

import { setChonkyDefaults } from 'chonky';
import { ChonkyIconFA } from 'chonky-icon-fontawesome';
setChonkyDefaults({ iconComponent: ChonkyIconFA });



window.my_file_browser = React.createElement(MyFileBrowser, {name: 'Testing'}, null)
