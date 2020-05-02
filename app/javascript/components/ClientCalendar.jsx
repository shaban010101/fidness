import React from 'react';
import Calendar from './Calendar';
import DatePicker from "react-datepicker";

class ClientCalendar extends Calendar {
  constructor(props){
    super(props)
    this.state = {
      startDate: new Date(),
      purchased_session_id: props.purchased_session_id,
      user_id: props.user_id,
      trainer_id: props.trainer_id,
      page: props.page
    };
  }

  addErrorToList = (error) => {
    var paragraph = document.createElement("P");
    var errorsList = document.getElementsByClassName("errors")[0];
    var textError = document.createTextNode(error);
    paragraph.appendChild(textError);
    var node = document.createElement("LI");
    var errorListItem =  node.appendChild(paragraph);
    errorsList.appendChild(errorListItem);
  }

  handleClick = (event) => {
    var time = event.toElement.textContent;
    var session_at = this.timeSelected(time);
    var addErrorToList = function(error) {
      var paragraph = document.createElement("P");
      var errorsList = document.getElementsByClassName("errors")[0];
      $(errorsList).empty();
      var textError = document.createTextNode(error);
      paragraph.appendChild(textError);
      var node = document.createElement("LI");
      var errorListItem =  node.appendChild(paragraph);
      errorsList.appendChild(errorListItem);
    };

    $.post('/future-session', { session_at: session_at, purchased_session_id: this.state.purchased_session_id, trainer_id: this.state.trainer_id }).done((response) => {
      $("#alert-success").css('display', 'block');
    }).fail(function(jqXHR, textStatus, errorThrown) {
      $("#alert-error").css('display', 'block');     
      if(jqXHR.status == 500) {
        addErrorToList('Sorry, something went wrong please try again');
      } else {
        jqXHR.responseJSON.errors.forEach(function(error) {
          addErrorToList(error);
        });    
      };
    });
  };

  render() {
    const { startDate } = this.state;
    var className = "calendar-" + this.state.page;

    return ( 
      <div className={className}> 
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
