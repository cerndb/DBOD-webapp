package ch.cern.dod.ui.renderer;

import ch.cern.dod.db.entity.DODJobStat;
import org.zkoss.zul.Label;
import org.zkoss.zul.Row;
import org.zkoss.zul.RowRenderer;

/**
 * Renderer for job stats
 * @author Daniel Gomez Blanco
 */
public class JobStatsRenderer implements RowRenderer{

    public void render(Row row, Object object) throws Exception {
        DODJobStat stat = (DODJobStat) object; 
        // the data append to each row with simple label
        row.appendChild(new Label(stat.getDbName()));
        row.appendChild(new Label(stat.getCommandName()));
        row.appendChild(new Label(String.valueOf(stat.getCount())));
        row.appendChild(new Label(String.valueOf(stat.getMeanDuration())));
    }
    
}