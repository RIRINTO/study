package chapter11;

import java.util.HashMap;
import java.util.Map;

public class Thermometer {
	//[��ġ, �µ�] ������ ������ Map Ÿ���� �ʵ带 ������
	private Map<String, Double> locationCelsiusMap = 
		new HashMap<String, Double>();
	
	//[��ġ, �µ�] ������ �߰���.
	public void setCelsius(String location, Double value) {
		locationCelsiusMap.put(location, value);
	}
	//location �Ķ���� ���� �ش��ϴ� ��ġ�� �����µ��� ����
	public Double getCelsius(String location) {
		return locationCelsiusMap.get(location);
	}
	//location �Ķ���� ���� �ش��ϴ� ��ġ�� ȭ���µ��� ����
	public Double getFahrenheit(String location) {
		Double celsius = getCelsius(location);
		
		if(celsius==null) {
			return null;
		}
		
		return celsius.doubleValue() * 1.8 + 32.0;
	}
	
	public String getInfo() {
		return "�µ��� ��ȯ�� 1.1";
	}
	
}
