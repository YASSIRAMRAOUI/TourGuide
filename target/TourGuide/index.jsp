<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />

<!-- Hero Section -->
<div class="relative bg-gradient-to-r from-blue-600 to-green-600 text-white py-20 overflow-hidden h-96">
    <!-- Swiper Container -->
    <div class="swiper-container absolute inset-0 w-full h-full">
        <div class="swiper-wrapper">
            <!-- Slide 1 -->
            <div class="swiper-slide">
                <img src="/assets/hero1.webp" alt="TourGuide Hero Image 1" class="w-full object-cover">
                <div class="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-40">
                    <h2 class="text-4xl font-bold mb-4">Explore the World</h2>
                    <p class="text-lg">Discover breathtaking destinations with our guided tours.</p>
                </div>
            </div>
            <!-- Slide 2 -->
            <div class="swiper-slide">
                <img src="/assets/hero2.jpg" alt="TourGuide Hero Image 2" class="w-full object-cover">
                <div class="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-40">
                    <h2 class="text-4xl font-bold mb-4">Adventure Awaits</h2>
                    <p class="text-lg">Experience thrilling activities and create unforgettable memories.</p>
                </div>
            </div>
            <!-- Slide 3 -->
            <div class="swiper-slide">
                <img src="/assets/hero3.webp" alt="TourGuide Hero Image 3" class="w-full object-cover">
                <div class="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-40">
                    <h2 class="text-4xl font-bold mb-4">Plan Your Journey</h2>
                    <p class="text-lg">Let us help you organize the perfect trip.</p>
                </div>
            </div>
            <!-- Slide 4 -->
            <div class="swiper-slide">
                <img src="/assets/hero4.jpg" alt="TourGuide Hero Image 3" class="w-full object-cover">
                <div class="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-40">
                    <h2 class="text-4xl font-bold mb-4">Feel free to reach out to us anytime</h2>
                    <p class="text-lg">24/7, and we will respond promptly without any obligation.</p>
                </div>
            </div>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
    </div>
</div>

<div class="p-8  px-20">
    <h1 class="text-4xl font-bold text-center mb-6">Trips in Morocco</h1>
        <p class="text-lg mb-4 font-serif">
            Embark on a journey of magic and fascination with trips in Morocco - your premier passage to an extraordinary realm of thrilling escapades! Through our meticulously crafted excursions,
            delve into Morocco's varied terrain and storied cultural legacy in a manner unparalleled.
            Roam across rugged landscapes, meander through lively urban hubs, and immerse yourself in the vivid hues and tastes of this captivating nation.
            Our dedication lies in transcending the commonplace, ensuring an unparalleled voyage that will etch itself into your memories for a lifetime.
        </p>

    <!-- Reservation Form Section -->
    <div class="grid grid-cols-1 md:grid-cols-2 my-8 gap-4">
        <div class="flex items-center justify-center">
            <img
                src="${pageContext.request.contextPath}/assets/hero4.jpg"
                class="h-full w-auto object-cover rounded-lg shadow-md"
                alt="Reservation Image"
            />
        </div>
        <div class="w-full max-w-lg bg-white shadow-md rounded-lg p-8">
            <h2 class="text-3xl font-semibold text-gray-800 mb-6 text-center">Make a Reservation</h2>
            <form action="ReservationServlet?action=insert" method="post" class="space-y-6">
                <!-- Tour Selection -->
                <div>
                    <label for="tourId" class="block text-sm font-medium text-gray-700 mb-1">Select Tour</label>
                    <select
                        name="tourId"
                        id="tourId"
                        required
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm"
                    >
                        <option value="">-- Select Tour --</option>
                        <c:forEach var="tour" items="${tours}">
                            <option value="${tour.tourId}">${tour.title}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Reservation Date -->
                <div>
                    <label for="reservationDate" class="block text-sm font-medium text-gray-700 mb-1">Reservation Date</label>
                    <input
                        type="date"
                        id="reservationDate"
                        name="reservationDate"
                        required
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm"
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
                        class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm"
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
    </div>


    <h1 class="text-4xl font-bold text-center mb-6"> Discover, Explore, and Experience the Magic…</h1>
        <p class="text-lg mb-4 font-serif">
            EStep into a world of enchantment and wonder with Morocco Lustrous - your ultimate gateway to a land of captivating adventures! With our expertly curated tours,
            you can explore the diverse landscapes and rich cultural heritage of Morocco like never before. Traverse through the rugged terrains, wander through the bustling cities,
            and soak in the vibrant colors and flavors of this enchanting country.
            We are committed to taking you beyond the ordinary and providing you with an exceptional travel experience that you will cherish forever.
        </p>
    <div class="grid grid-cols-2 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
            <a href="<c:url value='/TourServlet?action=listByCategory&category=casa' />" class="block w-full h-full">
                <img
                    src="${pageContext.request.contextPath}/assets/casanlanca.jpg"
                    alt="Casablanca"
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-black/50 opacity-100 opacity-100 transition-all duration-300 flex items-center justify-center">
                    <p class="text-white text-lg font-semibold px-4 text-center">
                        Discover Casablanca
                    </p>
                </div>
            </a>
        </div>

        
        <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
            <a href="<c:url value='/TourServlet?action=listByCategory&category=marrakech' />" class="block w-full h-full">
                <img
                    src="${pageContext.request.contextPath}/assets/marrakech.jpg"
                    alt="Marrakech"
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-black/50 opacity-0 opacity-100 transition-all duration-300 flex items-center justify-center">
                    <p class="text-white text-lg font-semibold px-4 text-center">
                    Discover Marrakech
                    </p>
                </div>
            </a>
        </div>

        <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
            <a href="<c:url value='/TourServlet?action=listByCategory&category=merzouga' />" class="block w-full h-full">
                <img
                    src="${pageContext.request.contextPath}/assets/merzouga.jpg"
                    alt="Merzouga"
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-black/50 opacity-0 opacity-100 transition-all duration-300 flex items-center justify-center">
                    <p class="text-white text-lg font-semibold px-4 text-center">
                    Discover Merzouga
                    </p>
                </div>
            </a>
        </div>

        <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
            <a href="<c:url value='/TourServlet?action=listByCategory&category=tanger' />" class="block w-full h-full">
                <img
                    src="${pageContext.request.contextPath}/assets/tanger.jpeg"
                    alt="Tanger"
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div class="absolute inset-0 bg-black/50 opacity-0 opacity-100 transition-all duration-300 flex items-center justify-center">
                    <p class="text-white text-lg font-semibold px-4 text-center">
                    Discover Tanger
                    </p>
                </div>
            </a>
        </div>

        <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
            <a href="<c:url value='/TourServlet?action=listByCategory&category=fes' />" class="block w-full h-full">
                <img
                    src="${pageContext.request.contextPath}/assets/fes.webp"
                    alt="Fes"
                    class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
                />
                <div href="<c:url value='/TourServlet?action=listByCategory&category=fes' />" class="absolute inset-0 bg-black/50 opacity-0 opacity-100 transition-all duration-300 flex items-center justify-center">
                    <p class="text-white text-lg font-semibold px-4 text-center">
                    Discover Fes
                    </p>
                </div>
            </a>
        </div>
    </div>

    <!-- FAQ Section -->
    <div class="py-4">
        <h1 class="text-4xl font-bold text-center text-gray-800 my-8">
            FAQs About Morocco
        </h1>
        
        <div class="space-y-4">
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

            <div class="border border-amber-200 rounded-lg overflow-hidden bg-white shadow-md">
                <button class="faq-question w-full text-left p-4 bg-amber-800 text-white font-semibold hover:bg-amber-700 transition-colors duration-200 flex justify-between items-center">
                    <span>11 thing to do in Morocco</span>
                    <svg class="w-5 h-5 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v12m6-6H6"/>
                    </svg>
                </button>
                <div class="faq-answer hidden p-4 text-gray-700 leading-relaxed">
                    <ul class="list-disc list-inside space-y-4 text-gray-700">
                        Morocco offers a wide range of activities to suit different interests. Here are some things to do in Morocco:
                        <li>Explore Marrakech: Wander through the vibrant souks, visit the historic Medina, and marvel at iconic sites like Jardin Majorelle and Koutoubia Mosque.</li>
                        <li>Visit Fes: Explore the ancient Fes Medina, home to historic landmarks such as Bou Inania Madrasa and the Al-Attarine Madrasa.</li>
                        <li>Experience the Sahara Desert: Take a camel trek into the mesmerizing dunes of the Sahara, and spend a night in a traditional desert camp.</li>
                        <li>Discover Chefchaouen: Explore the blue-painted streets of Chefchaouen nestled in the Rif Mountains, known for its picturesque charm.</li>
                        <li>Visit Casablanca: Explore Morocco's economic and business hub, visit the Hassan II Mosque, and experience the coastal atmosphere.</li>
                        <li>Explore Essaouira: Enjoy the coastal charm of Essaouira, known for its historic medina, sandy beaches, and vibrant arts scene.</li>
                        <li>Hike the Atlas Mountains: Embark on trekking adventures in the Atlas Mountains, where you can discover Berber villages and breathtaking landscapes.</li>
                        <li>Discover Rabat: Visit the capital city, Rabat, and explore historical sites like the Kasbah of the Udayas and the Royal Palace.</li>
                        <li>Experience Moroccan Cuisine: Indulge in the diverse and flavorful Moroccan cuisine, trying dishes like tagine, couscous, and mint tea.</li>
                        <li>Shop in Souks: Wander through the bustling souks (markets) in various cities, such as Marrakech or Fes, and shop for spices, textiles, and traditional crafts.</li>
                        Remember to adapt your activities based on your interests and the time of year you're visiting. Morocco's diverse landscapes and cultural richness offer a wide array of experiences for every traveler.
                    </ul>
                </div>
            </div>

            <div class="border border-amber-200 rounded-lg overflow-hidden bg-white shadow-md">
                <button class="faq-question w-full text-left p-4 bg-amber-800 text-white font-semibold hover:bg-amber-700 transition-colors duration-200 flex justify-between items-center">
                    <span>Tell me about the history of Morocco</span>
                    <svg class="w-5 h-5 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v12m6-6H6"/>
                    </svg>
                </button>
                <div class="faq-answer hidden p-4 text-gray-700 leading-relaxed">
                    <ul class="list-disc list-inside space-y-4 text-gray-700">
                        The history of Morocco is rich and diverse, marked by various influences and periods. Here's a concise overview:
                        <li>Ancient Morocco: Phoenicians, Carthaginians, and Romans were among the early civilizations in Morocco. The Berbers, indigenous people, have a deep-rooted history.</li>
                        <li>Islamic Era: Arab-Muslim influence began in the 7th century. Morocco became a center of Islamic culture, and various dynasties ruled, including the Almoravids and Almohads.</li>
                        <li>Al-Andalus Influence: In the medieval period, Morocco had ties with Al-Andalus (Islamic Iberia), leading to cultural and architectural influences.</li>
                        <li>Saadian and Alaouite Dynasties: The Saadian Dynasty ruled in the 16th century, followed by the Alaouite Dynasty, which continues to rule today. The Alaouite Sultanate established stability and expanded Morocco's influence.</li>
                        <li>European Colonialism: In the 19th and early 20th centuries, European powers, particularly France and Spain, sought influence in Morocco, leading to conflicts. The Treaty of Fez in 1912 made Morocco a French and Spanish protectorate.</li>
                        <li>Independence: Morocco regained independence in 1956. King Mohammed V led the nationalist movement, and his son, Hassan II, became king in 1961.</li>
                        <li>Modern Period: Morocco has since modernized while preserving its cultural identity. The country has been politically stable compared to some regional neighbors.</li>
                        Throughout its history, Morocco has been a crossroads of cultures, resulting in a unique blend of Arab, Berber, and European influences that contribute to its distinctive identity.
                    </ul>
                </div>
            </div>

            <div class="border border-amber-200 rounded-lg overflow-hidden bg-white shadow-md">
                <button class="faq-question w-full text-left p-4 bg-amber-800 text-white font-semibold hover:bg-amber-700 transition-colors duration-200 flex justify-between items-center">
                    <span>Popular festivals in Morocco</span>
                    <svg class="w-5 h-5 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v12m6-6H6"/>
                    </svg>
                </button>
                <div class="faq-answer hidden p-4 text-gray-700 leading-relaxed">
                    Morocco hosts various vibrant festivals throughout the year.
                    The Fes Festival of World Sacred Music celebrates global music and spirituality.
                    The Rose Festival in El Kelaa M'Gouna showcases the valley's blossoming roses.
                    Marrakech hosts the International Film Festival, attracting filmmakers worldwide.
                    Additionally, Eid al-Fitr and Eid al-Adha are significant religious celebrations.
                    The date-based Mawazine Festival in Rabat features diverse music genres.
                    Plan your visit to coincide with these events to experience Morocco's cultural richness.
                </div>
            </div>

            <div class="border border-amber-200 rounded-lg overflow-hidden bg-white shadow-md">
                <button class="faq-question w-full text-left p-4 bg-amber-800 text-white font-semibold hover:bg-amber-700 transition-colors duration-200 flex justify-between items-center">
                    <span>Traditional Moroccan clothing</span>
                    <svg class="w-5 h-5 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v12m6-6H6"/>
                    </svg>
                </button>
                <div class="faq-answer hidden p-4 text-gray-700 leading-relaxed">
                    Traditional Moroccan clothing includes the djellaba, a long hooded robe worn by both men and women.
                    Women often wear kaftans, intricately designed dresses, and hijabs or headscarves.
                    Men may also wear a fez, a distinctive hat. In rural areas, you might see Berber men in traditional robes and turbans.
                    The attire often reflects the rich cultural and historical influences in Morocco.
                </div>
            </div>

            <div class="border border-amber-200 rounded-lg overflow-hidden bg-white shadow-md">
                <button class="faq-question w-full text-left p-4 bg-amber-800 text-white font-semibold hover:bg-amber-700 transition-colors duration-200 flex justify-between items-center">
                    <span>Is it safe solo travel in Morocco</span>
                    <svg class="w-5 h-5 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v12m6-6H6"/>
                    </svg>
                </button>
                <div class="faq-answer hidden p-4 text-gray-700 leading-relaxed">
                    Solo travel in Morocco is generally considered safe, especially in well-touristed areas.
                    However, like any destination, it's essential to stay vigilant, be cautious in crowded places, and follow common-sense safety measures.
                    Respect local customs and dress modestly to minimize unwanted attention.
                    If you plan to explore more remote areas, hiring a local guide can enhance your experience and ensure safety.
                    Check travel advisories, stay informed, and embrace the rich cultural experiences Morocco has to offer.
                </div>
            </div>
        </div>
    </div>


    <!-- Activities Section -->
    <section>
        <div class="flex justify-between items-center py-8">
            <h2 class="text-3xl font-bold text-gray-800">Exciting Activities</h2>
        </div>
        <c:if test="${not empty activities}">
            <div class="flex overflow-hidden relative group" id="scroll-container"> <!-- Container for scrolling -->
                <div class="flex gap-6" id="scroll-content"> <!-- Content to scroll -->
                    <c:forEach var="activity" items="${activities}">
                        <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 rounded-lg shadow-md overflow-hidden hover:shadow-xl transition-shadow duration-300 flex-shrink-0 w-72"> <!-- Grid item -->
                            <c:choose>
                                <c:when test="${not empty activity.imagePath}">
                                    <a href="ActivityServlet?action=view&id=${activity.activityId}" class="hover:text-gray-400">
                                        <img
                                            src="${pageContext.request.contextPath}/${activity.imagePath}"
                                            alt="${activity.name}"
                                            class="h-48 w-full object-cover"
                                        />
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <img
                                        src="${pageContext.request.contextPath}/assets/defaultActivity.png"
                                        alt="Default Image"
                                        class="h-48 w-full object-cover"
                                    />
                                </c:otherwise>
                            </c:choose>
                            <div class="p-4">
                                <h3 class="text-lg font-semibold text-gray-300 mb-2">${activity.name}</h3>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
        <c:if test="${empty activities}">
            <p class="text-gray-500">No activities available at the moment.</p>
        </c:if>
    </section>

    <h1 class="text-4xl font-bold text-center my-6">Moroccan starters</h1>
        <p class="text-lg mb-4 font-serif">
            Usually served at the beginning of meals, Moroccan starters are presented as an accompaniment to main dishes.
            They vary from one region to another, but generally consist of a Moroccan salad of either raw or cooked vegetables, Briouates stuffed with chicken or minced meat,
            a ratatouille of peppers and tomatoes - the so-called Tektouta - and the famous Zaâlouk which is an eggplant puree.
            Each recipe has a special seasoning, and brings out its own flavour and colour.
        </p>

    <div class="grid grid-cols-2 md:grid-cols-2 lg:grid-cols-7 gap-4 py-8">
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

    <!-- Reviews Section -->
    <section class="py-8">
        <h2 class="text-3xl font-bold text-center mb-6">What Our Travelers Say</h2>
        <div class="flex overflow-hidden relative group" id="reviews-container"> <!-- Container for scrolling -->
            <div class="flex gap-6" id="reviews-content"> <!-- Content to scroll -->
                <c:forEach var="review" items="${reviews}">
                    <div class="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow duration-300 flex-shrink-0 w-72"> <!-- Grid item -->
                        <!-- User Info -->
                        <div class="flex items-center mb-4">
                            <c:choose>
                                <c:when test="${not empty review.userImagePath}">
                                    <img src="${pageContext.request.contextPath}/${review.userImagePath}" 
                                        alt="${review.userName}" 
                                        class="w-12 h-12 rounded-full object-cover">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/default-user.png" 
                                        alt="Default User" 
                                        class="w-12 h-12 rounded-full object-cover">
                                </c:otherwise>
                            </c:choose>
                            <div class="ml-4">
                                <p class="font-semibold text-lg">${review.userName}</p>
                                <p class="text-sm text-gray-500">${review.userEmail}</p>
                            </div>
                        </div>

                        <!-- Rating -->
                        <div class="flex items-center mb-4">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= review.rating}">
                                        <span class="text-yellow-500">★</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-gray-300">★</span>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>

                        <!-- Comment -->
                        <p class="text-gray-700">${review.comment}</p>

                        <!-- Tour Title -->
                        <p class="text-sm text-gray-500 mt-4">Tour: ${review.tourTitle}</p>

                        <!-- Review Date -->
                        <p class="text-sm text-gray-500 mt-2">Reviewed on: ${review.reviewDate}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <div class="flex flex-wrap items-center justify-between py-6">
        <div class="w-full md:w-1/2 px-4 text-center">
            <img class="rounded-lg shadow-md mx-auto" src="../assets/about2.jpg" alt="Mission">
        </div>
        <div class="w-full md:w-1/2 px-4">
            <h2 class="text-2xl font-semibold text-gray-700">Mission</h2>
            <p class="mt-2 text-gray-600">
                Morocco Lustrous mission is to connect people with Morocco's beauty and culture through safe, comfortable, and reliable transportation.
                We aim to deliver exceptional customer experiences,making each journey a discovery and adventure.
                Focused on sustainability and responsible tourism, we strive to positively impact communities and preserve Morocco's natural and cultural heritage,
                transforming your travel dreams into unforgettable realities.
            </p>
        </div>
    </div>


    <div class="mt-8 grid gap-4 grid-cols-1 md:grid-cols-4 lg:grid-cols-4">
    <!-- Box 1: Best Price Guarantee -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 p-6 rounded-lg shadow-md text-gray-700">
        <div class="flex flex-col items-center text-center">
            <!-- Icon -->
            <svg class="w-10 h-10 text-gray-200 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            <!-- Text -->
            <h3 class="text-xl font-bold text-gray-200">Best Price Guarantee</h3>
        </div>
    </div>

    <!-- Box 2: Hand-Picked Tours & Activities -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 p-6 rounded-lg shadow-md text-gray-700">
        <div class="flex flex-col items-center text-center">
            <!-- Icon -->
            <svg class="w-10 h-10 text-gray-200 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path>
            </svg>
            <!-- Text -->
            <h3 class="text-xl font-bold text-gray-200">Hand-Picked Tours & Activities</h3>
        </div>
    </div>

    <!-- Box 3: 24/7 Availability -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 p-6 rounded-lg shadow-md text-gray-700">
        <div class="flex flex-col items-center text-center">
            <!-- Icon -->
            <svg class="w-10 h-10 text-gray-200 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            <!-- Text -->
            <h3 class="text-xl font-bold text-gray-200">24/7 Availability</h3>
        </div>
    </div>

    <!-- Box 4: Official Guides & Driving Experts -->
    <div class="bg-gradient-to-r from-yellow-900 to-yellow-600 p-6 rounded-lg shadow-md text-gray-700">
        <div class="flex flex-col items-center text-center">
            <!-- Icon -->
            <svg class="w-10 h-10 text-gray-200 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
            </svg>
            <!-- Text -->
            <h3 class="text-xl font-bold text-gray-200">Official Guides & Driving Experts</h3>
        </div>
    </div>
</div>
</div>

<jsp:include page="/includes/footer.jsp" />





<!-- Chatbase Script -->
<script>
    (function() {
        if(!window.chatbase||window.chatbase("getState")!=="initialized"){
            window.chatbase=(...arguments)=>{
                if(!window.chatbase.q) {
                    window.chatbase.q=[]
                    }
                window.chatbase.q.push(arguments)
                };

            window.chatbase=new Proxy(
                window.chatbase, {
                    get(target,prop) {
                        if(prop==="q") {
                            return target.q
                        } return (...args)=>target(prop,...args)
                    }
                }
            )
        }
        const onLoad=function() {
            const script=document.createElement("script");
            script.src="https://www.chatbase.co/embed.min.js";
            script.id="8ABKDUKoimB_qCtyw8kB9";
            script.domain="www.chatbase.co";
            document.body.appendChild(script)
        };

        if (document.readyState==="complete"){
            onLoad()
        } else {
                window.addEventListener("load",onLoad)
        }
    })();
</script>

<!-- Swiper JS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<!-- Initialize Swiper -->
<script>
    const swiper = new Swiper('.swiper-container', {
        loop: true,
        effect: 'fade',
        autoplay: {
            delay: 3000,
            disableOnInteraction: false,
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
    });
</script>

<script>
    // Horizontal Scrolling
    function startScroll() {
        const scrollContainer = document.getElementById('scroll-container');
        const scrollContent = document.getElementById('scroll-content');

        // Duplicate the content to create a seamless loop
        scrollContent.innerHTML += scrollContent.innerHTML;

        let scrollSpeed = 1; // Adjust scroll speed (pixels per frame)
        let isScrolling = true;

        function scrollStep() {
            if (isScrolling) {
                scrollContainer.scrollBy(scrollSpeed, 0); // Scroll horizontally

                // Reset scroll position when reaching the end of the duplicated content
                if (scrollContainer.scrollLeft >= scrollContent.scrollWidth / 2) {
                    scrollContainer.scrollTo(0, 0); // Reset to the beginning
                }

                requestAnimationFrame(scrollStep); // Continue scrolling
            }
        }

        // Start scrolling automatically
        scrollStep();

        // Pause scrolling on hover
        scrollContainer.addEventListener('mouseenter', () => {
            isScrolling = false;
        });

        // Resume scrolling on mouse leave
        scrollContainer.addEventListener('mouseleave', () => {
            isScrolling = true;
            scrollStep();
        });
    }

    // Initialize the scroll
    startScroll();
</script>

<script>
    // FAQ Accordion
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
</script>

<script>
    // Auto-scroll for reviews
    function startReviewsScroll() {
        const reviewsContainer = document.getElementById('reviews-container');
        const reviewsContent = document.getElementById('reviews-content');

        // Duplicate the content to create a seamless loop
        reviewsContent.innerHTML += reviewsContent.innerHTML;

        let scrollSpeed = 1; // Adjust scroll speed (pixels per frame)
        let isScrolling = true;

        function scrollStep() {
            if (isScrolling) {
                reviewsContainer.scrollBy(scrollSpeed, 0); // Scroll horizontally

                // Reset scroll position when reaching the end of the duplicated content
                if (reviewsContainer.scrollLeft >= reviewsContent.scrollWidth / 2) {
                    reviewsContainer.scrollTo(0, 0); // Reset to the beginning
                }

                requestAnimationFrame(scrollStep); // Continue scrolling
            }
        }

        // Start scrolling automatically
        scrollStep();

        // Pause scrolling on hover
        reviewsContainer.addEventListener('mouseenter', () => {
            isScrolling = false;
        });

        // Resume scrolling on mouse leave
        reviewsContainer.addEventListener('mouseleave', () => {
            isScrolling = true;
            scrollStep();
        });
    }

    // Initialize the scroll
    startReviewsScroll();
</script>