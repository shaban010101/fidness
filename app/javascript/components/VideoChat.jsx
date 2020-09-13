import React, { useState, useCallback, Component } from 'react';
import Room from './Room';

class VideoChat extends Component {
  constructor(props) {
    super();
    this.state = {
      userName: props.userName,
      roomName: props.roomName
    }
  }

  componentDidMount() {
    this.fetchToken()
  }

  fetchToken = () => {
    const data = await fetch('/video/token', {
      method: 'POST',
      body: JSON.stringify({
        identity: this.userName,
        room: this.roomName
      }),
      headers: {
        'Content-Type': 'application/json'
      }
    }).then(res => res.json());
      setToken(data.token);
  }

  const handleLogout = useCallback(event => {
    setToken(null);
  }, []);

  let render;
  render = (
      if(token) {
        <Room roomName={this.roomName} token={this.token} handleLogout={handleLogout}/>;
      }
  )
  return render;
};

export default VideoChat