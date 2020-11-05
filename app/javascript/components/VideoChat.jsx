import React from 'react';
import { Component } from "react";
import Room from './Room';

class VideoChat extends Component {
  constructor(props) {
    super();
    this.state = {
      userName: props.user_name,
      roomName: props.room_name,
      token: null
    };
  }

  UNSAFE_componentWillMount() {
    if(this.state.roomName) {
      this.fetchToken();
    }
  }

  fetchToken = () => {
    let currentComponent = this;
    const data = fetch('/twilio/token' + '?' + 'room_id=' + this.state.roomName, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    }).then(response => response.json())
      .then(data => {
        currentComponent.setState({token : data.token });
      })
      .catch((error) => {
        console.error('Error:', error);
      });
  };

  handleLogout = () => {
    this.setState({ token: null });
  };

  render() {
    if (this.state.token) {
      return (<Room roomName={this.state.roomName} token={this.state.token} handleLogout={this.handleLogout}/>);
    } else {
      return (<p>Sorry there was an issue with connecting the video, please refresh the page to try again</p>);
    }
  }
};

export default VideoChat;

