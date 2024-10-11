import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2";

export default class extends Controller {
  static values = { charge: Number }

  connect() {
    this.startDate = -1;
    this.endDate = -1;
    $("input.datepicker").datepicker({
      dateFormat: "yy/mm/dd"
    });
    $("#dp-start-date").change((e) => {
      this.startDate = e.target.value;
      if (this.#calculateDate()) {
        this.#calculateCharge();
      }
    });
    $("#dp-end-date").change((e) => {
      this.endDate = e.target.value;
      if (this.#calculateDate()) {
        this.#calculateCharge();
      }
    });
    $("#hire-form").submit((e) => {
      e.preventDefault();
      this.#ajaxUp(e.target);
    });
  };
  #ajaxUp(form) {
    const requestDetails = {
      method: "POST",
      headers: { "Accept": "application/json", "Content-Type": "application/json"},
      body: JSON.stringify({ "authenticity_token": $('#hire-form input[name=authenticity_token]').val(), "rental": { "hire_start_date": this.startDate, "hire_end_date": this.endDate, "charge": parseFloat($('#charge').val().substr(1)) }, "vehicle_id": $('#vehicle-id').data('vehicleId') })
    }
    // console.log(requestDetails.body);
    fetch(form.action, requestDetails)
    .then(response => response.json())
    .then(data => {
      // Icons: warning, error, success, info, and question
      Swal.fire({
        title: data.status,
        text: data.message,
        icon: data.status.toLowerCase(),
        confirmButtonText: 'Cool'
      });
      console.log(data);
    });

  };
  #calculateCharge() {
    let the_cost = (this.numberOfDays * this.chargeValue).toFixed(2)
    $('#charge').val(`£${the_cost}`);
  };
  #calculateDate() {this.startDate
    this.numberOfDays = 0;
    // console.log(this.startDate, this.endDate);
    if (this.startDate <= 0 || this.endDate <= 0) {
      return false;
    } else {
      var nowDate = new Date();
      var date = nowDate.getDate() + '/' + (nowDate.getMonth()+1) + '/' + nowDate.getFullYear();
      const td = date;
      const sd = new Date(this.startDate);
      const ed = new Date(this.endDate);
      // console.log(new Date());
      // console.log(sd);
      // console.log(ed);
      if (sd < td || sd >= ed) {
        return false;
      } else {
        this.numberOfDays = (ed.getTime() - sd.getTime()) / (1000 * 60 * 60 * 24);
      }
      return true;
    }
  };

  #dateToEpoch2(thedate) {
    return thedate.setHours(0,0,0,0);
  };
}
