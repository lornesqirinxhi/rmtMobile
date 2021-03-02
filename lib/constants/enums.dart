enum ConnectivityType {
  Wifi,
  Mobile
}

enum EventType {
  Accident,
  Traffic,
  Danger,
  SOS,
  Construction
}

enum TabItem { wheel, setting, calendar, car }

const Map<TabItem, String> tabName = {
  TabItem.wheel: 'wheel',
  TabItem.setting: 'setting',
  TabItem.calendar: 'calendar',
  TabItem.car: 'car'
};