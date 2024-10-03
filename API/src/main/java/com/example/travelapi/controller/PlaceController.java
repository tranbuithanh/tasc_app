package com.example.travelapi.controller;
import com.example.travelapi.model.Place;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

@RestController
@CrossOrigin(origins = "*") // Cho phép truy cập từ mọi nguồn (origin)
public class PlaceController {

    @GetMapping("/api/places/getAllPlace")
    public List<Place> getAllPlaces() {
        return Arrays.asList(
                new Place("Hoi An", 4.7, "https://kyuchoian.com/userfiles/image/tour/hoi-an/2020/bo-anh-dep-hoi-an/pho-co/tren-cao/hoi-an-tren-cao-1.jpg"),
                new Place("Sai Gon", 4.9, "https://nanotravel.vn/wp-content/uploads/2024/04/ve-du-thuyen-song-sai-gon-7.png"),
                new Place("Da Lat", 5.0, "https://www.dalattrip.com/dulich/media/2017/12/thanh-pho-da-lat.jpg")

        );
    }
}
