import React from 'react';
import { Component } from "react";
import DatePicker from "react-datepicker";
import $ from 'jquery'

import "react-datepicker/dist/react-datepicker.css";

class Calendar extends Component {
  constructor(props) {
    super();
    this.state = {
      startDate: new Date(),
      user_id: props.user_id
    };
  }

  UNSAFE_componentWillMount() {
    this.handleChange(this.state.startDate);
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
    var available_at = date.toLocaleDateString();
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

  timeSelected = (time) => {
    var monthYear = document.getElementsByClassName('react-datepicker__current-month')[0].textContent;
    var day = document.getElementsByClassName('react-datepicker__day--selected')[0].textContent;
    var parsedDate = Date.parse(day + monthYear);
    var date = new Date(parsedDate);
    var timeParts = time.split(':');
    var unixTime = date.setHours(timeParts[0], timeParts[1]);
    return new Date(unixTime).toISOString();
  };

  handleClick = (event) => {
    var time = event.toElement.textContent;
    var available_at = this.timeSelected(time);
    var authenticityToken = $("meta[name='csrf-token']").attr("content");

    $.post('/availability', { available_at: available_at, user_id: this.state.user_id, authenticity_token: authenticityToken }).done((response) => {
      $("#alert-success").css('display', 'block');
    }).fail((jqXHR, textStatus, error) => {
      $("#alert-error").css('display', 'block');
      jqXHR.responseJSON.errors.forEach(function(error) {
        var errorsElement = document.getElementsByClassName("errors")[0];
        var listElement = document.createElement("LI");
        listElement.appendChild(document.createTextNode(error));
        errorsElement.appendChild(listElement);
      });
    });
  };

  minimumDate = () => {
    var date = new Date;
    var nextHour = date.getHours() + 1;
    date.setHours(nextHour, 0, 0);
    return date;
  };

  render() {
    const { startDate } = this.state;
      
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
          minDate={this.minimumDate()} 
          />
      </div>
    );
  }
}

export default Calendar
