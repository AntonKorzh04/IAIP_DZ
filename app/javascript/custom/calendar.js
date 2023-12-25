console.log('calendar.js loaded');

function CalendarControl() {
    // текущая дата
    const calendar = new Date();
    
    // сам календарь
    const calendarControl = {
        // текущая дата
        localDate: new Date(),

        // последний день предыдущего месяца
        prevMonthLastDate: null,

        // названия дней недели
        calWeekDays: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],

        // названия месяцев
        calMonthName: [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        
        // количество дней в месяце
        daysInMonth: function (month, year) {
            return new Date(year, month, 0).getDate();
        },

        // объект Date первого дня текущего месяца
        firstDay: function () {
            return new Date(calendar.getFullYear(), calendar.getMonth(), 1);
        },

        // объект Date последнего дня текущего месяца
        lastDay: function () {
            return new Date(calendar.getFullYear(), calendar.getMonth() + 1, 0);
        },

        // номер дня недели первого дня текущего месяца
        firstDayNumber: function () {
            return calendarControl.firstDay().getDay() + 1;
        },

        // номер дня недели последнего дня текущего месяца
        lastDayNumber: function () {
            return calendarControl.lastDay().getDay() + 1;
        },

        // последний день предыдущего месяца
        getPreviousMonthLastDate: function () {
            let lastDate = new Date(calendar.getFullYear(), calendar.getMonth(), 0).getDate();
            return lastDate;
        },

        // меняет месяц на предыдущий и обновляет интерфейс
        navigateToPreviousMonth: function (event) {
            event.preventDefault(); // предотвращаем выполнение действия по умолчанию (переход по ссылке)
            calendar.setMonth(calendar.getMonth() - 1);
            calendarControl.attachEventsOnNextPrev();
        },

        // меняет месяц на следующий и обновляет интерфейс
        navigateToNextMonth: function (event) {
            event.preventDefault(); // предотвращаем выполнение действия по умолчанию (переход по ссылке)
            calendar.setMonth(calendar.getMonth() + 1);
            calendarControl.attachEventsOnNextPrev();
        },

        // меняет месяц на текущий и обновляет интерфейс
        navigateToCurrentMonth: function () {
            let currentMonth = calendarControl.localDate.getMonth();
            let currentYear = calendarControl.localDate.getFullYear();
            calendar.setMonth(currentMonth);
            calendar.setYear(currentYear);
            calendarControl.attachEventsOnNextPrev();
        },

        // отображение текущего года в интерфейсе
        displayYear: function () {
            let yearLabel = document.querySelector(".calendar .calendar-year-label");
            yearLabel.innerHTML = calendar.getFullYear();
        },

        // отображение текущего месяца в интерфейсе
        displayMonth: function () {
            let monthLabel = document.querySelector(".calendar .calendar-month-label");
            monthLabel.innerHTML = calendarControl.calMonthName[calendar.getMonth()];
        },

        // обработчик события выбора даты
        selectDate: function (event) {
            event.preventDefault();
            
            var selectedTextContent =  `${event.target.textContent}`.trim()
            var selectedDate = `${selectedTextContent} ${calendarControl.calMonthName[calendar.getMonth()]} ${calendar.getFullYear()}`;
            console.log(selectedDate);
        },        

        // html код для элементов управления календарем и окна текущей даты
        plotSelectors: function () {
            document.querySelector(
                ".calendar"
            ).innerHTML += `
            <div class="calendar-inner">
                <div class="calendar-controls">
                    <div class="calendar-prev">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 128 128">
                                <path fill="#666" d="M88.2 3.8L35.8 56.23 28 64l7.8 7.78 52.4 52.4 9.78-7.76L45.58 64l52.4-52.4z"/>
                            </svg>
                        </a>
                    </div>

                    <div class="calendar-year-month">
                        <div class="calendar-month-label"></div>
                        <div>-</div>
                        <div class="calendar-year-label"></div>
                    </div>
                    
                    <div class="calendar-next">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 128 128">
                                <path fill="#666" d="M38.8 124.2l52.4-52.42L99 64l-7.77-7.78-52.4-52.4-9.8 7.77L81.44 64 29 116.42z"/>
                            </svg>
                        </a>
                    </div>
                </div>

                <div class="calendar-today-date">Today: 
                    ${calendarControl.calWeekDays[calendarControl.localDate.getDay()]}, 
                    ${calendarControl.localDate.getDate()}, 
                    ${calendarControl.calMonthName[calendarControl.localDate.getMonth()]} 
                    ${calendarControl.localDate.getFullYear()}
                </div>
                <div class="calendar-body"></div>
            </div>
            `;
        },

        // html код для названий дней недели
        plotDayNames: function () {
            for (let i = 0; i < calendarControl.calWeekDays.length; i++) {
                document.querySelector(".calendar .calendar-body").innerHTML += `<div>${calendarControl.calWeekDays[i]}</div>`;
            }
        },

        // html код для дат текущего и предыдущего месяца
        plotDates: function () {
            document.querySelector(".calendar .calendar-body").innerHTML = ""; // очищает все внутри тела календаря
            calendarControl.plotDayNames(); // html код для названий дней недели
            calendarControl.displayMonth(); // отображение текущего месяца в интерфейсе
            calendarControl.displayYear(); // отображение текущего года в интерфейсе
            let count = 1;
            let prevDateCount = 0; // количество отображаемых дней предыдущего месяца

            calendarControl.prevMonthLastDate = calendarControl.getPreviousMonthLastDate(); // последний день предыдущего месяца
            let prevMonthDatesArray = []; // массив с отображаемыми датами предыдущего месяца

            let calendarDays = calendarControl.daysInMonth(calendar.getMonth() + 1, calendar.getFullYear()); // количество дней в месяце

            // даты текущего месяца
            for (let i = 1; i < calendarDays; i++) {
                // пока день недели не равен дню недели первого дня месяца
                if (i < calendarControl.firstDayNumber()) {
                    prevDateCount += 1; // увеличиваем количество отображаемых дней предыдущего месяца
                    document.querySelector(
                        ".calendar .calendar-body"
                    ).innerHTML += `<div class="prev-dates"></div>`; // html код блока отображаемого дня предыдущего месяца
                    prevMonthDatesArray.push(calendarControl.prevMonthLastDate--); // добавляем отображаемые даты предыдущего месяца
                } else {
                    // добавляем даты текущего месяца, к каждой подключаем ссылку
                    document.querySelector(
                        ".calendar .calendar-body"
                    ).innerHTML += `
                        <div class="number-item" data-num=${count}>
                            <a class="dateNumber" href="#">
                                ${count++}
                            </a>
                        </div>
                    `;
                }
            }

            // оставшиеся даты месяца (последняя неполная неделя)
            for (let j = 0; j < prevDateCount + 1; j++) {
                document.querySelector(
                ".calendar .calendar-body"
                ).innerHTML += `
                <div class="number-item" data-num=${count}>
                    <a class="dateNumber" href="#">
                        ${count++}
                    </a>
                </div>
                `;
            }

            calendarControl.highlightToday(); // выделение текущей даты
            calendarControl.plotPrevMonthDates(prevMonthDatesArray); // добавление чисел в блоки дат предыдущего месяца
            calendarControl.plotNextMonthDates(); // добавление чисел в блоки дат следующего месяца
        },

        // присоединение обработчиков событий к элементам управления календаря
        attachEvents: function () {
            let prevBtn = document.querySelector(".calendar .calendar-prev a"); // ссылка перехода на предыдущий месяц
            let nextBtn = document.querySelector(".calendar .calendar-next a"); // ссылка перехода на следующий месяц
            let todayDate = document.querySelector(".calendar .calendar-today-date"); // блок с текущей датой
            let dateNumber = document.querySelectorAll(".calendar .dateNumber"); // все ссылки дней текущего месяца

            prevBtn.addEventListener("click", calendarControl.navigateToPreviousMonth); // добавление обработчика перехода на предыдущий месяц
            nextBtn.addEventListener("click", calendarControl.navigateToNextMonth); // добавление обработчика перехода на следующий месяц
            todayDate.addEventListener("click", calendarControl.navigateToCurrentMonth); // добавление обработчика перехода на текущий месяц
            for (var i = 0; i < dateNumber.length; i++) {
                dateNumber[i].addEventListener("click", calendarControl.selectDate, false); // добавление обработчика выбора даты
            }
        },

        // выделение текущей даты
        highlightToday: function () {
            let currentMonth = calendarControl.localDate.getMonth() + 1; // текущий месяц
            let changedMonth = calendar.getMonth() + 1; // отображаемый месяц
            let currentYear = calendarControl.localDate.getFullYear(); // текущий год
            let changedYear = calendar.getFullYear(); // отображаемый год

            // если в данный момент отображается текущий год и месяц
            if (currentYear === changedYear && currentMonth === changedMonth && document.querySelectorAll(".number-item")) {
                // текущему числу добавляем класс сегодняшней даты calendar-today
                document.querySelectorAll(".number-item")[calendar.getDate() - 1].classList.add("calendar-today");
            }
        },

        // добавление чисел в блоки дат предыдущего месяца
        plotPrevMonthDates: function(dates) {
            dates.reverse(); // разворачиваем массив, т.к. формировали в обратном порядке
            for (let i = 0; i < dates.length; i++) {
                // проверяем, есть ли даты предыдущего месяца
                if (document.querySelectorAll(".prev-dates")) {
                    document.querySelectorAll(".prev-dates")[i].textContent = dates[i]; // добавляем в блок даты предыдущего месяца число
                }
            }
        },

        // добавление чисел в блоки дат следующего месяца
        plotNextMonthDates: function() {
            let childElemCount = document.querySelector('.calendar-body').childElementCount;
            
            // 6 недель отображается + 7 названий дней недели
            if(childElemCount > 42 ) {
                let diff = 49 - childElemCount; // количество отображаемых дат следующего месяца
                calendarControl.loopThroughNextDays(diff); // html код для дат следующего месяца
            }

            // 5 недель отображается + 7 названий дней недели
            if(childElemCount > 35 && childElemCount <= 42 ) {
            let diff = 42 - childElemCount; // количество отображаемых дат следующего месяца
            calendarControl.loopThroughNextDays(diff); // html код для дат следующего месяца
            }
        },

        // html код для дат следующего месяца
        loopThroughNextDays: function(count) {
            if(count > 0) {
                for (let i = 1; i <= count; i++) {
                    document.querySelector('.calendar-body').innerHTML += `<div class="next-dates">${i}</div>`;
                }
            }
        },

        // перерисовывает календарь и присоединяет обработчики событий после изменения месяца
        attachEventsOnNextPrev: function () {
            calendarControl.plotDates(); // html код для дат текущего и предыдущего месяца
            calendarControl.attachEvents(); // присоединение обработчиков событий к элементам управления календаря
        },

        // иницилизация календаря
        init: function () {
            calendarControl.plotSelectors(); // html код для элементов управления календарем и окна текущей даты
            calendarControl.plotDates(); // html код для дат текущего и предыдущего месяца
            calendarControl.attachEvents(); // присоединение обработчиков событий к элементам управления календаря
        }
    };

    // инициализируем календарь
    calendarControl.init();
}

// создаем объект календаря
const calendarControl = new CalendarControl();