package kr.eddi.demo;


import kr.eddi.demo.novel.NovelServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class NovelTestCase {


    @Autowired
    NovelServiceImpl service;

    @Test
    void createCategory() {
        service.createCategory(1L, "판타지");
        service.createCategory(2L, "무협");
        service.createCategory(3L, "로맨스");
        service.createCategory(4L, "현대");
    }
}
