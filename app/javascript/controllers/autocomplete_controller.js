// app/javascript/controllers/autocomplete_controller.js
import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input"]

    suggest() {
        const query = this.inputTarget.value.trim();

        if (query === "") {
            document.getElementById("breed-suggestions").innerHTML = "";
            return;
        }

        fetch(`/breeds?query=${encodeURIComponent(query)}`, {
            headers: {
                Accept: "text/vnd.turbo-stream.html",
            },
        })
            .then((response) => response.text())
            .then((html) => {
                document.getElementById("breed-suggestions").innerHTML = html;
            });
    }

    selectSuggestion(event) {
        const suggestion = event.currentTarget.dataset.suggestion
        this.inputTarget.value = suggestion
        document.getElementById("breed-suggestions").innerHTML = ""
    }
}
