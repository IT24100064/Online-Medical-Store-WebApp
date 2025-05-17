<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Place Order</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col" >
 <!-- Header -->
  <header class="w-full py-6 px-8 flex justify-between items-center bg-white shadow">
    <div>
      <span class="text-xl font-semibold tracking-widest text-gray-700">PHARMACARE</span>
    </div>
    <nav class="space-x-8 text-sm">
      <a href="#" class="text-gray-700 hover:text-blue-700">Shop</a>
      <a href="#" class="text-gray-700 hover:text-blue-700">About</a>
      <a href="#" class="text-gray-700 hover:text-blue-700">Blog</a>
      <a href="#" class="text-gray-700 hover:text-blue-700">Contact</a>
      <a href="#" class="text-gray-700 hover:text-blue-700">
        <svg xmlns="http://www.w3.org/2000/svg" class="inline h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h18M9 3v18M15 3v18"/>
        </svg>
      </a>
    </nav>
  </header>
  <main class="min-h-screen flex items-center justify-center bg-[radial-gradient(ellipse_at_center,_var(--tw-gradient-stops))] from-blue-400 via-purple-300 to-blue-100">
    <div class="w-full max-w-md bg-white rounded-2xl shadow-xl p-8 flex flex-col items-center">
        <h2 class="text-2xl font-bold mb-2 text-center">Place New Order</h2>
        <form action="orders" method="post" class="w-full space-y-4" onsubmit="return validateForm();">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Name</label>
                <input type="text" name="name" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:outline-none" />
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Contact</label>
                <input type="text" name="contact" id="contact" maxlength="10" required
                       oninput="this.value = this.value.replace(/[^0-9]/g, '');"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:outline-none" />
                <div id="contactError" class="text-red-500 text-xs mt-1 hidden">Contact number must be exactly 10 digits.</div>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Address</label>
                <textarea name="address" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:outline-none"></textarea>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Age</label>
                <input type="number" name="age" id="age" min="18" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:outline-none" />
                <div id="ageError" class="text-red-500 text-xs mt-1 hidden">Age must be 18 or older.</div>
            </div>
            <div>
                <h3 class="text-lg font-semibold mb-2">Medicines</h3>
                <div id="medicineContainer">
                    <div class="flex space-x-2 medicine-entry mb-2">
                        <select name="medicine" required class="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:outline-none">
                            <option value="Paracetamol">Paracetamol</option>
                            <option value="Ibuprofen">Ibuprofen</option>
                            <option value="Amoxicillin">Amoxicillin</option>
                            <option value="Cetirizine">Cetirizine</option>
                            <option value="Metformin">Metformin</option>
                        </select>
                        <input type="number" name="quantity" min="1" placeholder="Quantity" required
                               oninput="this.value = this.value.replace(/[^0-9]/g, ''); if(this.value === '0') this.value='';"
                               class="w-24 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:outline-none" />
                    </div>
                </div>
                <button type="button" onclick="addMedicineField()"
                        class="mt-2 text-blue-600 hover:underline text-sm">Add Another Medicine</button>
            </div>
            <button type="submit"
                    class="w-full py-2 bg-blue-600 text-white rounded-lg font-semibold hover:bg-blue-700 transition">Place Order</button>
        </form>
    </div>
    </main>
    <footer class="bg-blue-600 text-white pt-10">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-8 pb-8">
        <!-- Information -->
        <div>
          <h3 class="text-lg font-bold mb-4">Information</h3>
          <ul class="space-y-2">
            <li><a href="#" class="hover:underline">About Us</a></li>
            <li><a href="#" class="hover:underline">Delivery</a></li>
            <li><a href="#" class="hover:underline">Privacy Policy</a></li>
            <li><a href="#" class="hover:underline">Terms &amp; Conditions</a></li>
            <li><a href="#" class="hover:underline">App Deletion</a></li>
          </ul>
        </div>

        <!-- Marketplace -->
        <div>
          <h3 class="text-lg font-bold mb-4">Marketplace</h3>
          <ul class="space-y-2">
            <li><a href="#" class="hover:underline">Partner Pharmacies</a></li>
            <li><a href="#" class="hover:underline">Seller Login</a></li>
          </ul>
        </div>

        <!-- Reach Us -->
        <div>
          <h3 class="text-lg font-bold mb-4">Reach Us</h3>
          <ul class="space-y-2">
            <li><a href="#" class="hover:underline">Contact Us</a></li>
            <li><a href="#" class="hover:underline">Site Map</a></li>
            <li><a href="#" class="hover:underline">Brands</a></li>
          </ul>
        </div>

        <!-- Newsletter -->
        <div>
          <h3 class="text-lg font-bold mb-4">Newsletter</h3>
          <p class="mb-3 text-sm">Don't miss any updates or promotions by signing up to our newsletter.</p>
          <form class="flex mb-2">
            <input type="email" placeholder="Your email" class="w-full px-3 py-2 rounded-l bg-white text-gray-700 focus:outline-none" />
            <button type="submit" class="bg-blue-800 px-4 py-2 rounded-r text-white font-semibold hover:bg-blue-900">SEND</button>
          </form>
          <div class="flex items-center mb-2">
            <input type="checkbox" id="policy" class="mr-2 accent-blue-800" />
            <label for="policy" class="text-xs">I have read and agree to the <a href="#" class="underline">Privacy Policy</a></label>
          </div>
          <div class="mt-3">
            <span class="font-semibold">Follow us:</span>
            <div class="flex space-x-3 mt-2">
              <!-- Social Icons -->
              <a href="#" class="text-blue-300 hover:text-white">
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M24 4.6c-.9.4-1.9.7-2.9.8a5.1 5.1 0 0 0 2.2-2.8c-1 .6-2 .9-3.1 1.2A5.1 5.1 0 0 0 16.7 3c-2.8 0-5.1 2.3-5.1 5.1 0 .4 0 .8.1 1.2C7.7 9.1 4.1 7.3 1.7 4.6c-.4.7-.6 1.6-.6 2.5 0 1.8.9 3.3 2.2 4.2-.8 0-1.5-.2-2.2-.6v.1c0 2.5 1.8 4.5 4.2 5-.4.1-.8.2-1.2.2-.3 0-.6 0-.9-.1.6 1.9 2.4 3.3 4.5 3.3A10.3 10.3 0 0 1 0 21.5c2.3 1.5 5.1 2.4 8.1 2.4 9.7 0 15-8 15-15v-.7c1-.7 1.9-1.6 2.6-2.6z"/>
                </svg>
              </a>
              <a href="#" class="text-blue-300 hover:text-white">
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12 2.2c3.2 0 3.6 0 4.9.1 1.2.1 2 .2 2.5.4.6.2 1 .5 1.4 1 .4.4.7.8 1 1.4.2.5.3 1.3.4 2.5.1 1.3.1 1.7.1 4.9s0 3.6-.1 4.9c-.1 1.2-.2 2-.4 2.5-.2.6-.5 1-1 1.4-.4.4-.8.7-1.4 1-.5.2-1.3.3-2.5.4-1.3.1-1.7.1-4.9.1s-3.6 0-4.9-.1c-1.2-.1-2-.2-2.5-.4-.6-.2-1-.5-1.4-1-.4-.4-.7-.8-1-1.4-.2-.5-.3-1.3-.4-2.5C2.2 15.6 2.2 15.2 2.2 12s0-3.6.1-4.9c.1-1.2.2-2 .4-2.5.2-.6.5-1 1-1.4.4-.4.8-.7 1.4-1 .5-.2 1.3-.3 2.5-.4C8.4 2.2 8.8 2.2 12 2.2z"/>
                </svg>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </footer>
    <script>
        function addMedicineField() {
            const container = document.getElementById('medicineContainer');
            const div = document.createElement('div');
            div.className = 'flex space-x-2 medicine-entry mb-2';
            div.innerHTML = `
                <select name="medicine" required class="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:outline-none">
                    <option value="Paracetamol">Paracetamol</option>
                    <option value="Ibuprofen">Ibuprofen</option>
                    <option value="Amoxicillin">Amoxicillin</option>
                    <option value="Cetirizine">Cetirizine</option>
                    <option value="Metformin">Metformin</option>
                </select>
                <input type="number" name="quantity" min="1" placeholder="Quantity" required
                       oninput="this.value = this.value.replace(/[^0-9]/g, ''); if(this.value === '0') this.value='';"
                       class="w-24 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:outline-none" />
            `;
            container.appendChild(div);
        }

        function validateForm() {
            const contactInput = document.getElementById('contact');
            const contactError = document.getElementById('contactError');
            const ageInput = document.getElementById('age');
            const ageError = document.getElementById('ageError');

            const contactValue = contactInput.value.trim();
            const ageValue = parseInt(ageInput.value, 10);

            let valid = true;

            if (!/^\d{10}$/.test(contactValue)) {
                contactError.classList.remove('hidden');
                valid = false;
            } else {
                contactError.classList.add('hidden');
            }

            if (isNaN(ageValue) || ageValue < 18) {
                ageError.classList.remove('hidden');
                valid = false;
            } else {
                ageError.classList.add('hidden');
            }

            return valid;
        }
    </script>
</body>
</html>
