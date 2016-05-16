import React, { Component } from 'react';
import {
  ListView,
  StyleSheet,
  Text,
  TouchableWithoutFeedback,
  View,
} from 'react-native';

export class Tweets extends Component {
  constructor(props) {
    super(props);

    const data = fetchData();

    const dataSource = new ListView.DataSource({
      rowHasChanged: (r1, r2) => r1 !== r2,
    });

    this.state = {
      dataSource: dataSource.cloneWithRows(data),
    };
  }

  render() {
    return (
      <ListView style={{backgroundColor: 'white'}}
        dataSource={this.state.dataSource}
        renderRow={this.renderRow}
        />
    );
  }

  renderRow(rowData) {
    return (
      <View style={{flexDirection: 'row', overflow: 'hidden', padding: 8}}>
        <View>
          <View style={{
            width: 60,
            height: 60,
            borderRadius: 60/2,
            backgroundColor: rowData.avatarBackgroundColor,
          }}
          />
          <Text style={{textAlign: 'center'}}>Data</Text>
        </View>
        <View style={{flex: 1, marginLeft: 8}}>
          <Text>{rowData.name}</Text>
          <Text>{rowData.text}</Text>
        </View>
      </View>
    );
  }
}

const COLORS = [
  '#0000ff',
  '#a52a2a',
  '#00ffff',
  '#a9a9a9',
  '#808080',
  '#008000',
  '#d3d3d3',
  '#ff00ff',
  '#ffa500',
  '#800080',
  '#ff0000',
  '#ffff00',
];
function pickRandom(array) {
  return array[Math.floor(Math.random() * array.length)];
}

function fetchData() {
  // performance, not app-launch performance.
  const data = require('./data.json');
  // Assigning a random color because I didn't include that in our fake tweet
  // data set ¯\_(ツ)_/¯.
  data.forEach((fakeTweet) => fakeTweet['avatarBackgroundColor'] = pickRandom(COLORS));
  return data;
}
