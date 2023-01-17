// ignore_for_file: constant_identifier_names

const BASE_URL = "https://127.0.0.1:8000";

// login
const LOGIN = "/account/login";
const ACCOUNT = "/account";
const PROFILE_USER = "/staff/profileuser/%s";

// sales
const PRODUCT = '/product';
const PRODUCT_INVENTORY = '/ImportInventory/inventory/%s';
const PRODUCT_IN_STORE_DIFF = '/ImportInventory/getproductinstorediff/%s';
const CUSTOMER = '/customer';
const POST_ORDER = '/order';

// REGISTER CALENDAR WORK
const TIMEWORK = '/timework?idStore=%s';
const REGISTER_TIMEWORK = '/registercalendar';
const CALENDARWORK_INWEEK = '/calendarwork/calanderinweek/%s';
const CALENDARWORK_STAFF_INWEEK = '/calendarwork/calendarinweek/staff';
const CHECK_IN = '/checkin';
const CHECK_OUT = '/checkout';

// STORE
const STORE_PRO = '/store/%s';
