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
        <p class="text-lg mb-4">
            Embark on a journey of magic and fascination with trips in Morocco – your premier passage to an extraordinary realm of thrilling escapades! Through our meticulously crafted excursions, delve into Morocco’s varied terrain and storied cultural legacy in a manner unparalleled. Roam across rugged landscapes, meander through lively urban hubs, and immerse yourself in the vivid hues and tastes of this captivating nation. Our dedication lies in transcending the commonplace, ensuring an unparalleled voyage that will etch itself into your memories for a lifetime.
        </p>
    <div class="grid grid-cols-2 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
            <img
                src="${pageContext.request.contextPath}/assets/casanlanca.jpg"
                alt="Casablanca"
                class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
            />
            <a href="<c:url value='/TourServlet?action=listByCategory&category=casa' />" class="absolute inset-0 bg-black/50 opacity-0 opacity-100 transition-all duration-300 flex items-center justify-center">
                <p class="text-white text-lg font-semibold px-4 text-center">
                Discover Casablanca
                </p>
            </a>
        </div>

        <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
            <img
                src="${pageContext.request.contextPath}/assets/marrakech.jpg"
                alt="Marrakech"
                class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
            />
            <a href="<c:url value='/TourServlet?action=listByCategory&category=marrakech' />" class="absolute inset-0 bg-black/50 opacity-0 opacity-100 transition-all duration-300 flex items-center justify-center">
                <p class="text-white text-lg font-semibold px-4 text-center">
                Discover Marrakech
                </p>
            </a>
        </div>

        <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
            <img
                src="${pageContext.request.contextPath}/assets/merzouga.jpg"
                alt="Merzouga"
                class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
            />
            <a href="<c:url value='/TourServlet?action=listByCategory&category=merzouga' />" class="absolute inset-0 bg-black/50 opacity-0 opacity-100 transition-all duration-300 flex items-center justify-center">
                <p class="text-white text-lg font-semibold px-4 text-center">
                Discover Merzouga
                </p>
            </a>
        </div>

        <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
            <img
                src="${pageContext.request.contextPath}/assets/tanger.jpeg"
                alt="Tanger"
                class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
            />
            <a href="<c:url value='/TourServlet?action=listByCategory&category=tanger' />" class="absolute inset-0 bg-black/50 opacity-0 opacity-100 transition-all duration-300 flex items-center justify-center">
                <p class="text-white text-lg font-semibold px-4 text-center">
                Discover Tanger
                </p>
            </a>
        </div>

        <div class="group relative aspect-[4/3] overflow-hidden rounded-lg shadow-lg cursor-pointer">
            <img
                src="${pageContext.request.contextPath}/assets/fes.webp"
                alt="Fes"
                class="w-full h-full object-cover transition-all duration-300 group-hover:scale-110"
            />
            <a href="<c:url value='/TourServlet?action=listByCategory&category=fes' />" class="absolute inset-0 bg-black/50 opacity-0 opacity-100 transition-all duration-300 flex items-center justify-center">
                <p class="text-white text-lg font-semibold px-4 text-center">
                Discover Fes
                </p>
            </a>
        </div>
    </div>

    <!-- FAQ Section -->
    <dive class="py-8">
        <h1 class="text-4xl font-bold text-center text-gray-800 my-8">
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
                                    <img src="${pageContext.request.contextPath}/${activity.imagePath}" alt="${activity.name}" class="h-48 w-full object-cover">
                                    <a href="ActivityServlet?action=view&id=${activity.activityId}" class="hover:text-gray-400">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/defaultActivity.png" alt="Default Image" class="h-48 w-full object-cover">
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