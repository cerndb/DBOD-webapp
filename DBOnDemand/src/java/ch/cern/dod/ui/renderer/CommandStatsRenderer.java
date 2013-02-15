package ch.cern.dod.ui.renderer;

import ch.cern.dod.db.entity.DODCommandStat;
import ch.cern.dod.util.DODConstants;
import ch.cern.dod.util.DateTimeHelper;
import org.zkoss.util.resource.Labels;
import org.zkoss.zul.Label;
import org.zkoss.zul.Row;
import org.zkoss.zul.RowRenderer;

/**
 * Renderer for job stats
 * @author Daniel Gomez Blanco
 */
public class CommandStatsRenderer implements RowRenderer{

    public void render(Row row, Object object) throws Exception {
        DODCommandStat stat = (DODCommandStat) object;
        row.setStyle("padding-top: 0px; padding-bottom: 0px");
        row.setHeight("24px");
        // the data append to each row with simple label
        row.appendChild(new Label(Labels.getLabel(DODConstants.LABEL_JOB + stat.getCommandName())));
        row.appendChild(new Label(String.valueOf(stat.getCount())));
        row.appendChild(new Label(DateTimeHelper.timeToString(stat.getMeanDuration())));
    }
    
}
