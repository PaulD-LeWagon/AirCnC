import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2";
const log = something => console.log(typeof something, something);
export default class extends Controller {
  static values = { charge: Number }

  static targets = ["form", "startDate", "endDate", "charge"]

  connect() {
    this.startDate = -1;
    this.endDate = -1;
  };
  onDPChange(e) {
    this.startDate = this.startDateTarget.value;
    this.endDate = this.endDateTarget.value;
    if (this.#calculateDate()) {
      this.#calculateCharge();
    }
  };
  onSubmit(e) {
    e.preventDefault();

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        // Icons: warning, error, success, info, and question
        Swal.fire({
          title: this.#capitalise(data.status),
          text: data.message,
          icon: data.status,
          confirmButtonText: 'Cool',
          customClass: {
            confirmButton: `btn btn-${data.status} btn-lg`,
          }
        });
        console.log(data);
      })

  };

  #calculateDate() {
    this.numberOfDays = 0;
    if (this.startDate <= 0 || this.endDate <= 0) {
      return false;
    } else {
      var nowDate = new Date();
      var date = nowDate.getDate() + '/' + (nowDate.getMonth()+1) + '/' + nowDate.getFullYear();
      const td = date;
      const sd = new Date(this.startDate);
      const ed = new Date(this.endDate);
      if (sd < td || sd >= ed) {
        return false;
      } else {
        this.numberOfDays = (ed.getTime() - sd.getTime()) / (1000 * 60 * 60 * 24);
      }
      return true;
    }
  };

  #calculateCharge() {
    this.chargeTarget.value = `£${(this.numberOfDays * this.chargeValue).toFixed(2)}`;
  };

  #capitalise(strOfWords) {
    const words = strOfWords.split(" ");
    return words.map((word) => { return word[0].toUpperCase() + word.substring(1); }).join(" ");
  };

}
