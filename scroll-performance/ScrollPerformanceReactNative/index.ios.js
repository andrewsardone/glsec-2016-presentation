/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  ListView,
  StyleSheet,
  Text,
  View
} from 'react-native';

class ScrollPerformanceReactNative extends Component {
  constructor(props) {
    super(props);
    // Obviously this is blocking, but this is just a quick demo around scroll
    // performance, not app-launch performance.
    const data = require('./data.json');
    const dataSource = new ListView.DataSource({
      rowHasChanged: (r1, r2) => r1 !== r2,
    });

    this.state = {
      dataSource: dataSource.cloneWithRows(data),
    };
  }

  render() {
    return (
      <ListView
        dataSource={this.state.dataSource}
        renderRow={this.renderRow}
      />
    );
  }

  renderRow(rowData) {
    const defaultTextTyle = {
      fontSize: 17,
    };
    return (
      <View style={{flexDirection: 'row', padding: 8, overflow: 'hidden'}}>
        <View>
          <View style={{
              width: 60,
              height: 60,
              borderRadius: 60/2,
              backgroundColor: 'red', // TODO: Use random color
            }}
          />
          <Text style={[defaultTextTyle, {textAlign: 'center'}]}>Date</Text>
        </View>
        <View style={{flex: 1, paddingLeft: 8}}>
          <Text style={defaultTextTyle}>{rowData['name']}</Text>
          <Text style={defaultTextTyle}>
            {rowData['text']}
          </Text>
        </View>
      </View>
    );
  };
}

AppRegistry.registerComponent('ScrollPerformanceReactNative', () => ScrollPerformanceReactNative);
