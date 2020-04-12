import React from 'react';
import { Component } from "react";
import DatePicker from "react-datepicker";

import "react-datepicker/dist/react-datepicker.css";

class Calendar extends Component {
  constructor(props) {
    super();
    this.state = {
      startDate: new Date(),
      user_id: props.user_id
    };
  }
  
  componentDidUpdate() {
    var el = document.getElementsByClassName("react-datepicker__time-list-item--selected")[0];
    var url = window.location.pathname.match(/trainers/);
    if (el != undefined && url == null) {
      el.addEventListener('dblclick',  this.handleClick);
    }
  }

  componentWillUnmount() {
    var el = document.getElementsByClassName("react-datepicker__time-list-item--selected")[0];
    var url = window.location.pathname.match(/trainers/);

    if (el != undefined && url == null) {
      el.removeEventListener('dblclick', this.handleClick);
    }
  }

  handleChange = date => {
    var available_at = date.toISOString();
     $.get('/availability', { available_at: available_at, user_id: this.state.user_id }).then((response) => {
        var availabilities = response.periods.map(function(period) {
          var p = new Date(period);
          return p;
        });
       
        this.setState({
          startDate: date,
          availabilities: availabilities
        });
     });
  };

  handleClick = (event) => {
    var time = event.toElement.textContent;
    var monthYear = document.getElementsByClassName('react-datepicker__current-month')[0].textContent;
    var day = document.getElementsByClassName('react-datepicker__day--selected')[0].textContent;
    var parsedDate = Date.parse(day + monthYear);
    var date = new Date(parsedDate);
    var timeParts = time.split(':');
    var unixTime = date.setHours(timeParts[0], timeParts[1]);
    var available_at = new Date(unixTime).toISOString();

    $.post('/availability', { available_at: available_at, user_id: this.state.user_id }).done((response) => {
      $("#alert-success").css('display', 'block');
    }).fail((jqXHR, textStatus, error) => {
      $("#alert-error").css('display', 'block');
      response.errors.forEach(function(error) {
        var errorsElement = document.getElementsByClassname("errors")[0];
        var listElement = document.createElement("LI");
        var errorListItem = listElement.appendChild(error);
        errorsElement.appendChild(listElement);
      });
    });
  };

  render() {
    const { startDate } = this.state;
    let button;
    

    return ( 
      <div className="calendar"> 
        <DatePicker
          timeFormat="HH:mm"
          showTimeSelect
          timeIntervals={60}
          inline
          selected={this.state.startDate}
          onChange={this.handleChange}
          excludeTimes={this.state.availabilities}
          />
      </div>
    );
  }
}

export default Calendar
