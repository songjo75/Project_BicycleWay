package com.mbc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mbc.domain.BicycleProduct;
import com.mbc.mapper.BuyMapper;

@Service
public class RentService {
		
		private static final String BASE_URL = "http://openapi.seoul.go.kr:8088";
		private static final int BATCH_SIZE = 1000;
	    // 정류소를 저장할 리스트
		private static List<Map<String, Object>> allStops = new ArrayList<>();

	    // 생성자.   객체 생성 시, 함수 호출한다.
	    public RentService() {
	        fetchRentStops();
			
	    }

	    // 생성자에서 호출. "openAPI에 모든 자전거 대여소 정보를 요청"하여,  필요한 List<Map<String,Object>> 만들어두기. 
	    private void fetchRentStops() {
	        allStops.clear();
	        int start = 1;
	        RestTemplate restTemplate = new RestTemplate();
	        ObjectMapper objectMapper = new ObjectMapper();

	        while (true) {
	            int end = start + BATCH_SIZE - 1;
	            // openAPI 요청 url
	            String url = BASE_URL + "/" + "4d45677667736f6e33394177507475" + "/json/bikeStationMaster/" + start + "/" + end + "/";
	            
	            try {
	                String response = restTemplate.getForObject(url, String.class);   // json형태
	                JsonNode root = objectMapper.readTree(response);   // Json문자열을  JsonNode 로 변경

	                // JSON 구조가 올바른지 확인
	                if (!root.has("bikeStationMaster")) {
	                    System.err.println("API 응답에 'bikeStationMaster'가 없음.");
	                    break;
	                }

	                JsonNode bikeStops = root.path("bikeStationMaster").path("row");
	                if (bikeStops.isMissingNode() || !bikeStops.isArray()) {
	                    System.out.println("API 응답에 'row' 데이터가 없음.");
	                    break;
	                }

	                // 딕셔너리 리스트에서  딕셔너리를 하나씩 꺼내와 ,  필요한 항목만 Map 으로 만들어, 리스트에 추가. 
	                for (JsonNode stop : bikeStops) {
	                    Map<String, Object> stopData = new HashMap<>();
	                    stopData.put("ADDR", stop.path("ADDR1").asText());
	                    stopData.put("LAT", stop.path("LAT").asDouble());
	                    stopData.put("LOT", stop.path("LOT").asDouble());
	                    allStops.add(stopData);
	                }

	                int totalCount = root.path("bikeStationMaster").path("list_total_count").asInt();
	                if (end >= totalCount) break;
	                start += BATCH_SIZE;
	                Thread.sleep(500);
	            } catch (Exception e) {
	                e.printStackTrace();
	                break;
	            }
	        }
	        System.out.println("총 대여소 개수: " + allStops.size());
	    }

	    // allStops 자전거 대여소에서, 검색위치에 해당하는 자료Map만 가져와 FilteredList 에 넣기. 
	    public List<Map<String, Object>> searchPlace(String location) {
	        List<Map<String, Object>> filteredStops = new ArrayList<>();
	        
	        for (Map<String, Object> stop : allStops) {
	        	
	          //  주소에 검색위치명 포함하는 자료Map만 가져와
	     //   if ( (stop.get("ADDR").toString().contains(location)) && (Double.parseDouble((String)(stop.get("LAT"))) != 0.0) && (Double.parseDouble((String)(stop.get("LOT"))) != 0.0) ) {   
	          if ( (stop.get("ADDR").toString().contains(location)) &&  !( stop.get("LAT").toString().equals("0.0") )  && !( stop.get("LOT").toString().equals("0.0") ) ) {   
	        	  //	System.out.println("#######"+location);
	                filteredStops.add(stop);
	            }
	        }
	        
	    //    System.out.println("#asdfsadfasdf"+filteredStops);
	    //    System.out.println("#asdfsadfasdf"+filteredStops.size());
	        return filteredStops;
	    }

	    
	}
	
