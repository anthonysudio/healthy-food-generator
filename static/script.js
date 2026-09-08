
document.addEventListener("DOMContentLoaded", function() {
    const generateBtn = document.getElementById("generate-btn");
    const mealCard = document.getElementById("meal-card");
    const spinner = document.getElementById("spinner");
    const errorAlert = document.getElementById("error-alert");
    const countrySelect = document.getElementById("country-select");

    if (generateBtn) {
        generateBtn.addEventListener("click", function() {

        spinner.classList.remove("d-none");
        mealCard.classList.add("d-none");
        if (errorAlert) {
            errorAlert.classList.add("d-none");
        }

        const selectedCountry = countrySelect ? countrySelect.value : "All";

        // Request a random meal from Flask backend route
        fetch("/api/random-meal?country=" + encodeURIComponent(selectedCountry))
            .then(function(response) {
                if (!response.ok) {
                    throw new Error("Server error: response was not ok");
                }
                return response.json();
            })
            .then(function(data) {
                if (data.meal) {
                    // Update image if available in database (image or image_url column)
                    const mealImg = document.getElementById("meal-image");
                    const imageUrl = data.meal.image_url || data.meal.image;
                    
                    if (imageUrl && mealImg) {
                        mealImg.src = imageUrl;
                        mealImg.alt = data.meal.name;
                        mealImg.classList.remove("d-none");
                    } else if (mealImg) {
                        mealImg.classList.add("d-none");
                    }


                    // Update main details
                    document.getElementById("meal-name").textContent = data.meal.name || "Unknown Meal";
                    document.getElementById("meal-country").textContent = data.meal.country || "Global";
                    document.getElementById("meal-desc").textContent = data.meal.description ||"";
                    document.getElementById("meal-ingredients").textContent = data.meal.ingredients || "";
                    document.getElementById("meal-calories").textContent = Math.round(data.meal.calories || 0) + " cal";

                    // Update nutrition breakdown
                    document.getElementById("meal-protein").textContent = Math.round(data.meal.protein || 0) + "g";
                    document.getElementById("meal-carbs").textContent = Math.round(data.meal.carbs || 0) + "g";
                    document.getElementById("meal-fat").textContent = Math.round(data.meal.fat || 0) + "g";
                    document.getElementById("meal-sodium").textContent = Math.round(data.meal.sodium || 0) + "mg";

                    const mealIdInput = document.getElementById("meal-id-input");
                        if (mealIdInput) {
                            mealIdInput.value = data.meal.id;
                        }


                    // Display the populated meal card
                    mealCard.classList.remove("d-none");
                    mealCard.querySelector(".card-body").scrollTop = 0;
                } else {
                    throw new Error("No meal data received from server");
                }
            })
            .catch(function(error) {
                console.error("Error fetching meal:", error);
                if (errorAlert) {
                    errorAlert.classList.remove("d-none");
                }
            })
            .finally(function() {
                // Hide spinner regardless of success or failure
                spinner.classList.add("d-none");
            });
    });
    }
});