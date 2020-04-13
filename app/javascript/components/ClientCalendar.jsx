import React from 'react';
import Calendar from './Calendar';
import DatePicker from "react-datepicker";

class ClientCalendar extends Calendar {
  constructor(props){
    super(props)
  }

  componentDidUpdate() {

  }

  componentWillUnmount() {
   
  }

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
          includeTimes={this.state.availabilities}
          />
      </div>
    );
  }
}

export default ClientCalendar
