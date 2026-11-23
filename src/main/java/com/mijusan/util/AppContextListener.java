package com.mijusan.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.File;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String realPath = sce.getServletContext().getRealPath("/WEB-INF/database.sqlite");
        if (realPath != null) {
            File f = new File(realPath);
            if (f.exists()) {
                Database.init(f.getAbsolutePath());
                System.out.println("[AppContextListener] SQLite Database initialized at: " + f.getAbsolutePath());
                return;
            }
        }
        System.out.println("[AppContextListener] Using fallback SQLite Database: " + Database.getDbPath());
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {}
}
