import moment from 'moment';

export default class DateUtils {
    static getFromString(dateString, lang = "en-gb") {
        moment.locale(lang);
        let m = moment(dateString).startOf('day');

        return m.isValid() ? m.toDate() : DateUtils.today;
    }

    static getDateOrEmpty(date, lang = "en-gb"){
        return !date || date === "" ? null : DateUtils.getFromString(date, lang);
    }

    static get today() {
        return moment().startOf('day').toDate();
    }

    static format(date, lang = "en-gb") {
        if (!date) return "";

        moment.locale(lang);
        return moment(date).startOf('day').format('L');
    }

    static isBetween(date, start, end) {
        if (date && start && end) {
            let newDate = DateUtils.getDateWithoutTime(date);
            let newStart = DateUtils.getDateWithoutTime(start);
            let newEnd = DateUtils.getDateWithoutTime(end);

            return newStart <= newDate && newDate <= newEnd;
        }
        else {
            return false;
        }
    }

    static getNumberOfMonths( fromDate, toDate) {
        if (!fromDate) {
            fromDate = DateUtils.today;
        }

        if (!toDate) {
            toDate = DateUtils.today;
        }

        let noOfMonths = toDate.getMonth() - fromDate.getMonth()
            + (12 * (toDate.getFullYear() - fromDate.getFullYear()));

        if (toDate.getDate() < fromDate.getDate()) {
            noOfMonths--;
        }

        return noOfMonths;
    }

    static getDateWithoutTime(date, lang = "en-gb") {
        if (!date) {
            date = DateUtils.today;
        }

        moment.locale(lang);

        return moment(date).startOf('day').toDate();
    }

    static getCurrentYear( lang = "en" ) {
        moment.locale(lang)
        return moment().startOf('day').year();
    }

    static getStartDayQueryFormat( date ) {
        return moment.utc(date).startOf('day').format('YYYY-MM-DDT00:00');
    }

    static getEndDayQueryFormat( date ) {
        return moment.utc(date).startOf('day').format('YYYY-MM-DDT23:59');
    }

    static getQueryFormat( date ) {
        return moment.utc(date).startOf('day').format('YYYY-MM-DDThh:mm');
    }

    
    static getAllMonths( lang = "en-gb" ) {
        moment.locale(lang)
        return moment.months();
    }

    static getCurrentMonthName( lang = "en-gb" ) {
        moment.locale(lang);

        return moment.months()[new Date().getMonth()];
    }

    static getMonthStartDate( year, month, lang = "en-gb" ) {
        moment.locale(lang);

        return moment([year, month]).toDate();
    }

    static getMonthEndDate( year, month, lang = "en-gb" ) {
        moment.locale(lang);

        return moment([year, month]).endOf('month').toDate();
    }
}