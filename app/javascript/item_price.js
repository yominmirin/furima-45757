const calculation = () =>{
  const priceInput = document.getElementById("item-price");
  const taxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = Number(priceInput.value);

    if (price >= 300 && price <= 9999999) {
      const fee = Math.floor(price * 0.1);
      const gain = Math.floor(price - fee);
      taxPrice.textContent = fee;
      profit.textContent = gain;
    } else {
      taxPrice.textContent = "";
      profit.textContent = "";
    };
  });
};

window.addEventListener('turbo:load', calculation);
window.addEventListener('turbo:render', calculation);