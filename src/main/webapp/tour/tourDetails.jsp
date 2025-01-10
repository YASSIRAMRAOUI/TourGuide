<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<!-- Full-Width Tour Image -->
<div class="w-full h-96 bg-gray-200 flex items-center justify-center">
    <c:if test="${tour.imagePath != null && !tour.imagePath.isEmpty()}">
        <img src="${pageContext.request.contextPath}/${tour.imagePath}" alt="${tour.title}"
             class="h-full w-full object-fill">
    </c:if>
    <c:if test="${tour.imagePath == null || tour.imagePath.isEmpty()}">
        <img src="${pageContext.request.contextPath}/assets/default.png" alt="Default Image"
             class="h-full w-full object-fill">
    </c:if>
</div>

<div class="px-20 py-2">
    <h1 class="text-2xl font-bold text-gray-800 text-center">${tour.title}</h1>
    <p class="text-sm text-gray-600 mt-1">${tour.description}</p>
</div>

<!-- Map and Reservation Form -->
<div class="grid grid-cols-1 sm:grid-cols-2 gap-6 p-6">
    <div class="bg-white p-4 rounded-lg shadow">
        <h2 class="text-lg font-semibold text-gray-800 mb-4">Make a Reservation</h2>
        <form action="ReservationServlet?action=insert" method="post" class="space-y-4">
            <!-- Tour ID -->
            <input type="hidden" name="tourId" value="${tour.tourId}" />

            <!-- Reservation Date -->
            <div>
                <label for="reservationDate" class="block text-sm font-medium text-gray-700 mb-1">Reservation Date</label>
                    <input
                        type="date"
                        id="reservationDate"
                        name="reservationDate"
                        required
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-2 focus:ring-teal-500 focus:border-teal-500"
                    >
            </div>

            <!-- Number of People -->
            <div>
                <label for="numberOfPeople" class="block text-sm font-medium text-gray-700 mb-1">Number of People</label>
                    <input
                        type="number"
                        id="numberOfPeople"
                        name="numberOfPeople"
                        min="1"
                        required
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-2 focus:ring-teal-500 focus:border-teal-500"
                    >
            </div>

            <!-- Submit Button -->
            <div>
                <button
                    type="submit"
                    class="w-full bg-teal-500 text-white font-medium py-2 px-4 rounded-md shadow-sm hover:bg-teal-600 focus:outline-none focus:ring-2 focus:ring-teal-400 transition duration-300"
                >
                Reserve Now
                </button>
            </div>
        </form>
    </div>

    <!-- Map Embed Code -->
    <c:if test="${not empty tour.mapEmbedCode}">
        <div class="map-container rounded-lg shadow-md">
            <c:out value="<iframe src='${tour.mapEmbedCode}' width='100%' height='300' style='border:0;' allowfullscreen='' loading='lazy' referrerpolicy='no-referrer-when-downgrade'></iframe>" escapeXml="false" />
        </div>
        </c:if>
    </div>
</div>

<div class="max-w-8xl mx-auto p-8">
    <!-- Image Grid -->
    <div class="grid grid-cols-1 md:grid-cols-1 lg:grid-cols-7 gap-4">
            <!-- Desert Experience -->
            <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
                <img 
                    src="${pageContext.request.contextPath}/assets/img1.png" 
                    alt="Desert Experience" 
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-all duration-300">
                    <div class="absolute inset-0 flex items-center justify-center">
                        <p class="text-white text-lg font-semibold px-4 text-center">
                            Tajin blbr9o9
                        </p>
                    </div>
                </div>
            </div>

            <!-- Sahara Group -->
            <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
                <img 
                    src="${pageContext.request.contextPath}/assets/img2.png" 
                    alt="Sahara Experience" 
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-all duration-300">
                    <div class="absolute inset-0 flex items-center justify-center">
                        <p class="text-white text-lg font-semibold px-4 text-center">
                            Chbakia
                        </p>
                    </div>
                </div>
            </div>

            <!-- Mountain Visit -->
            <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
                <img 
                    src="${pageContext.request.contextPath}/assets/img3.png" 
                    alt="Mountain Visit" 
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-all duration-300">
                    <div class="absolute inset-0 flex items-center justify-center">
                        <p class="text-white text-lg font-semibold px-4 text-center">
                            Ma3rfthach
                        </p>
                    </div>
                </div>
            </div>

            <!-- Desert Activities -->
            <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
                <img 
                    src="${pageContext.request.contextPath}/assets/img4.png" 
                    alt="Desert Activities" 
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-all duration-300">
                    <div class="absolute inset-0 flex items-center justify-center">
                        <p class="text-white text-lg font-semibold px-4 text-center">
                            Tajin dcscso
                        </p>
                    </div>
                </div>
            </div>

            <!-- Cultural Experience -->
            <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
                <img 
                    src="${pageContext.request.contextPath}/assets/img5.png" 
                    alt="Cultural Experience" 
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-all duration-300">
                    <div class="absolute inset-0 flex items-center justify-center">
                        <p class="text-white text-lg font-semibold px-4 text-center">
                            Brad datay
                        </p>
                    </div>
                </div>
            </div>

            <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
                <img 
                    src="${pageContext.request.contextPath}/assets/img6.png" 
                    alt="Cultural Experience" 
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-all duration-300">
                    <div class="absolute inset-0 flex items-center justify-center">
                        <p class="text-white text-lg font-semibold px-4 text-center">
                            Cscsou
                        </p>
                    </div>
                </div>
            </div>

            <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
                <img 
                    src="${pageContext.request.contextPath}/assets/img7.png" 
                    alt="Cultural Experience" 
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-all duration-300">
                    <div class="absolute inset-0 flex items-center justify-center">
                        <p class="text-white text-lg font-semibold px-4 text-center">
                            Hta hadi ma3rfthach
                        </p>
                    </div>
                </div>
            </div>
    </div>
</div>


<div class="grid grid-cols-1 sm:grid-cols-4 gap-6 m-8">
    <!-- Location Card -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 shadow-md rounded-lg p-4 flex items-center">
        <i class="fas fa-map-marker-alt text-red-500 text-2xl mr-2"></i>
        <div>
            <p class="text-white text-sm"><strong>Location:</strong></p>
            <p class="text-white text-base">${tour.location}</p>
        </div>
    </div>

    <!-- Date Card -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 shadow-md rounded-lg p-4 flex items-center">
        <i class="fas fa-calendar-alt text-green-500 text-2xl mr-2"></i>
        <div>
            <p class="text-white text-sm"><strong>Date:</strong></p>
            <p class="text-white text-base">${tour.date}</p>
        </div>
    </div>

    <!-- Category Card -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 shadow-md rounded-lg p-4 flex items-center">
        <i class="fas fa-tags text-yellow-500 text-2xl mr-2"></i>
        <div>
            <p class="text-white text-sm"><strong>Category:</strong></p>
            <p class="text-white text-base">${tour.category}</p>
        </div>
    </div>
                
    <!-- Price Card -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 shadow-md rounded-lg p-4 flex items-center">
        <i class="fas fa-dollar-sign text-blue-500 text-2xl mr-2"></i>
        <div>
            <p class="text-white text-sm"><strong>Price:</strong></p>
            <p class="text-white text-base">${tour.price}</p>
        </div>
    </div>
</div>

<div class="max-w-3xl mx-auto">
    <h1 class="text-4xl font-bold text-center text-gray-800 mb-8">
        FAQs About Morocco
    </h1>
        
        <div class="space-y-4">
            <!-- Best Places FAQ Item -->
            <div class="rounded-lg overflow-hidden bg-white shadow-md">
                <button class="faq-question w-full text-left p-4 bg-amber-800 text-white font-semibold hover:bg-amber-700 transition-colors duration-200 flex justify-between items-center">
                    <span>Best places to visit in Morocco</span>
                    <svg class="w-5 h-5 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v12m6-6H6"/>
                    </svg>
                </button>
                <div class="faq-answer hidden p-4 text-gray-700 leading-relaxed">
                    Morocco offers diverse attractions. Explore Marrakech's bustling souks, 
                    visit the historic Fes Medina, wander through the blue streets of Chefchaouen, 
                    and experience the Sahara Desert's unique landscapes. Don't miss the coastal 
                    charm of Essaouira and the ancient ruins of Volubilis.
                </div>
            </div>

            <!-- Weather FAQ Item -->
            <div class="border border-amber-200 rounded-lg overflow-hidden bg-white shadow-md">
                <button class="faq-question w-full text-left p-4 bg-amber-800 text-white font-semibold hover:bg-amber-700 transition-colors duration-200 flex justify-between items-center">
                    <span>Weather in Morocco throughout the year</span>
                    <svg class="w-5 h-5 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v12m6-6H6"/>
                    </svg>
                </button>
                <div class="faq-answer hidden p-4 text-gray-700 leading-relaxed">
                    Morocco experiences diverse climates. Coastal areas like Casablanca have 
                    a Mediterranean climate, with mild, wet winters and warm, dry summers. 
                    Inland cities like Marrakech have a hot desert climate, with scorching 
                    summers and cooler winters. The Atlas Mountains witness snow in winter. 
                    The Sahara Desert is extremely hot during the day and can be cold at night. 
                    It's best to plan based on the region and the time of year for your 
                    preferred weather.
                </div>
            </div>

            <!-- Languages FAQ Item -->
            <div class="border border-amber-200 rounded-lg overflow-hidden bg-white shadow-md">
                <button class="faq-question w-full text-left p-4 bg-amber-800 text-white font-semibold hover:bg-amber-700 transition-colors duration-200 flex justify-between items-center">
                    <span>Languages spoken in Morocco</span>
                    <svg class="w-5 h-5 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v12m6-6H6"/>
                    </svg>
                </button>
                <div class="faq-answer hidden p-4 text-gray-700 leading-relaxed">
                    Morocco is multilingual, with Arabic being the official language. 
                    Moroccan Arabic (Darija) is widely spoken. Berber languages, such as 
                    Tamazight, are also common, especially in rural areas. French is used 
                    in government, business, and education, and many Moroccans are proficient 
                    in it. English is increasingly spoken in tourist areas, but proficiency 
                    may vary. Embracing basic Arabic phrases or French can enhance your 
                    travel experience.
                </div>
            </div>

            <!-- Currency FAQ Item -->
            <div class="border border-amber-200 rounded-lg overflow-hidden bg-white shadow-md">
                <button class="faq-question w-full text-left p-4 bg-amber-800 text-white font-semibold hover:bg-amber-700 transition-colors duration-200 flex justify-between items-center">
                    <span>Currency in Morocco</span>
                    <svg class="w-5 h-5 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v12m6-6H6"/>
                    </svg>
                </button>
                <div class="faq-answer hidden p-4 text-gray-700 leading-relaxed">
                    The currency used in Morocco is the Moroccan dirham (MAD). It's advisable 
                    to exchange currency upon arrival or use ATMs in major cities. Credit cards 
                    are widely accepted in urban areas, but it's wise to carry some cash, 
                    especially in rural locations. Keep in mind that some smaller establishments 
                    may only accept cash. Check the current exchange rates and be aware of any 
                    fees associated with currency exchange.
                </div>
            </div>

            <!-- Best Time FAQ Item -->
            <div class="border border-amber-200 rounded-lg overflow-hidden bg-white shadow-md">
                <button class="faq-question w-full text-left p-4 bg-amber-800 text-white font-semibold hover:bg-amber-700 transition-colors duration-200 flex justify-between items-center">
                    <span>What is the best time to visit Morocco?</span>
                    <svg class="w-5 h-5 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v12m6-6H6"/>
                    </svg>
                </button>
                <div class="faq-answer hidden p-4 text-gray-700 leading-relaxed">
                    The best time to visit Morocco is during spring (March to May) and fall 
                    (September to November) when the weather is mild and pleasant. Avoid the 
                    scorching summer temperatures, especially in inland areas. Winter 
                    (December to February) is a good time for coastal cities, but the Atlas 
                    Mountains and desert regions can be chilly. Consider your preferred 
                    activities – spring and fall are ideal for general travel, while winter 
                    may suit those interested in the desert or winter sports in the mountains.
                </div>
        </div>
    </div>
</div>

    <!-- Modal -->
    <div id="imageModal" class="fixed inset-0 hidden bg-black/90 z-50 p-6">
        <div class="relative w-full h-full flex items-center justify-center">
            <!-- Close Button -->
            <button 
                onclick="closeModal()" 
                class="absolute top-4 right-4 text-white hover:text-gray-300 transition-colors"
            >
                <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
            
            <!-- Modal Image -->
            <img 
                id="modalImage" 
                src="" 
                alt="Enlarged view" 
                class="max-h-[90vh] max-w-[90vw] object-contain"
            />
        </div>
    </div>

<!-- Associated Activity Section -->
<div class="m-4">
    <h2 class="text-xl font-semibold text-gray-700 flex items-center mb-4">
        <i class="fas fa-route mr-2"></i> Associated Activity
    </h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <c:forEach var="activity" items="${activities}">
            <div class="bg-white shadow-md rounded-lg overflow-hidden hover:shadow-lg transition-shadow duration-300">
                <a href="ActivityServlet?action=view&id=${activity.activityId}">
                    <c:if test="${activity.imagePath != null && !activity.imagePath.isEmpty()}">
                        <img src="${pageContext.request.contextPath}/${activity.imagePath}"
                             alt="${activity.name}"
                             class="h-48 w-full object-cover">
                    </c:if>
                    <c:if test="${activity.imagePath == null || activity.imagePath.isEmpty()}">
                        <img src="${pageContext.request.contextPath}/assets/defaultBg.png"
                             alt="Default Activity Image"
                             class="h-48 w-full object-cover">
                    </c:if>
                </a>
                <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 p-4">
                    <h3 class="text-lg font-semibold text-gray-300 mb-2">
                        <a href="ActivityServlet?action=view&id=${activity.activityId}" class="hover:text-gray-400">
                            ${activity.name}
                        </a>
                    </h3>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Footer -->
<jsp:include page="/includes/footer.jsp" />

<script>
    document.querySelectorAll('.faq-question').forEach(question => {
        question.addEventListener('click', () => {
            const answer = question.nextElementSibling;
            const icon = question.querySelector('svg');
            const isOpen = !answer.classList.contains('hidden');
                
            // Close all answers
            document.querySelectorAll('.faq-answer').forEach(ans => {
                ans.classList.add('hidden');
            });
            document.querySelectorAll('.faq-question svg').forEach(svg => {
                svg.classList.remove('rotate-45');
            });
            
            // Open clicked answer if it was closed
            if (!isOpen) {
                answer.classList.remove('hidden');
                icon.classList.add('rotate-45');
            }
        });
    });

    const modal = document.getElementById('imageModal');
    const modalImg = document.getElementById('modalImage');
        
    // Add click handlers to all images
    document.querySelectorAll('.group img').forEach(img => {
        img.addEventListener('click', () => {
            modal.classList.remove('hidden');
            modalImg.src = img.src;
        });
    });

    // Close modal function
    function closeModal() {
        modal.classList.add('hidden');
    }

    // Close on escape key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') closeModal();
    });

    // Close on clicking outside image
    modal.addEventListener('click', (e) => {
        if (e.target === modal) closeModal();
    });
</script>